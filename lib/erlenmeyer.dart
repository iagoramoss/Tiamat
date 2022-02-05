import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import './bluetooth.dart';

class Erlenmeyer extends StatefulWidget {
  const Erlenmeyer({Key? key}) : super(key: key);

  @override
  _ErlenmeyerState createState() => _ErlenmeyerState();
}

class _ErlenmeyerState extends State<Erlenmeyer> {
  @override
  Widget build(BuildContext context) {
    BluetoothController bluetooth = context.watch<BluetoothController>();

    return LiquidCustomProgressIndicator(
      value: double.parse(bluetooth.percentStr) / 100,
      valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
      backgroundColor: Colors.black12,
      direction: Axis.vertical,
      shapePath: erlenmeyerShape(),
      center: Text(
        '  ${double.parse(bluetooth.percentStr).toStringAsFixed(0)}%',
        style: const TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: 20,
        ),
      ),
    );
  }
}

Path erlenmeyerShape() {
  return Path()
    ..moveTo(45, 0)
    ..lineTo(45, 16)
    ..lineTo(12, 135)
    ..quadraticBezierTo(8, 155, 25, 155)
    ..lineTo(82, 155)
    ..quadraticBezierTo(104, 155, 98, 135)
    ..lineTo(65, 16)
    ..lineTo(65, 0)
    ..lineTo(40, 0)
    ..close();
}
