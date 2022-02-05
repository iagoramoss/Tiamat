import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

const serviceUUID = '6E400001-B5A3-F393-E0A9-E50E24DCCA9E', txUUID = '6E400002-B5A3-F393-E0A9-E50E24DCCA9E', rxUUID = '6E400003-B5A3-F393-E0A9-E50E24DCCA9E';

String connectText = 'conectar';
bool found = false, enabled = true, connected = false, isReading = false;

BluetoothCharacteristic? txChar, rxChar, unidChar, dezChar, centChar;
BluetoothDevice? device;
BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

class BluetoothController extends ChangeNotifier{
  String percentStr = '000';

  Future<void> enableButtons() async{
    enabled = true;
    notifyListeners();
  }

  Future<BluetoothDevice?> getDevice() async{
    FlutterBlue flutterBlue = FlutterBlue.instance;
    late BluetoothDevice device;

    await flutterBlue.startScan(timeout: const Duration(seconds: 5));

    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if(r.device.name == 'Tiamat'){
          found = true;
          device = r.device;

          device.state.listen((state){
            deviceState = state;
            notifyListeners();
          });

          flutterBlue.stopScan();
          break;
        }
      }
    });

    await flutterBlue.stopScan();

    if(found){
      return device;
    }
  }

  Future<void> findChar() async{
    List<BluetoothService>? services = await device?.discoverServices();

    services ??= [];

    for(BluetoothService service in services){
      if(service.uuid.toString().toUpperCase() == serviceUUID){
        for(BluetoothCharacteristic c in service.characteristics){
          switch(c.uuid.toString().toUpperCase()){
            case txUUID:
              txChar = c;
              break;

            case rxUUID:
              rxChar = c;
              break;
          }
        }
      }
    }
  }

  Future<void> connectToDevice() async{
    if(deviceState != BluetoothDeviceState.connected){
      device = await getDevice();

      if(found){
        rxChar = null;
        txChar = null;

        await device?.connect();
        deviceState = BluetoothDeviceState.connected;
        notifyListeners();

        await findChar();

        await rxChar?.setNotifyValue(true);
        rxChar?.value.listen((value) async{
          String strValue = utf8.decode(value).toString();

          if(strValue.isNotEmpty){
            percentStr = strValue;
            print(percentStr);

            if(percentStr == '100'){
              enabled = true;
            }

            notifyListeners();
          }
        });

        connected = true;
      }
    }

    else{
      await device?.disconnect();
      deviceState = BluetoothDeviceState.disconnected;

      connected = false;
      found = false;

      percentStr = '0';
      notifyListeners();
    }
  }

  Future<void> writeChar() async{
    txChar?.write(utf8.encode('1'));
  }
}