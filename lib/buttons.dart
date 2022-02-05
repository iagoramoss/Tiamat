import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import './bluetooth.dart';
import './alert.dart';

Color textColor = Colors.white, enabledColor = const Color(0xff6188ff), disabledColor = const Color(0xff800000);

class Button extends StatefulWidget {
  String text;
  Color buttonColor;
  Color textColor;
  VoidCallback onPressed;

  Button({Key? key, required this.text, required this.buttonColor, required this.onPressed, required this.textColor}) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  double buttonHeight = 50, buttonWidth = 160;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerEvent details){
        setState((){
          Color aux = widget.textColor;
          widget.textColor = widget.buttonColor;
          widget.buttonColor = aux;

          buttonHeight -= 5;
          buttonWidth -= 10;
        });
      },
      onPointerUp: (PointerEvent details){
        setState((){
          Color aux = widget.textColor;
          widget.textColor = widget.buttonColor;
          widget.buttonColor = aux;

          buttonHeight += 5;
          buttonWidth += 10;
        });
      },
      child: SizedBox(
        height: buttonHeight,
        width: buttonWidth,
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(widget.buttonColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          onPressed: widget.onPressed,
          child: Text(
            widget.text.toUpperCase(),
            style: TextStyle(
              color: widget.textColor,
              fontFamily: 'Ubuntu',
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class BluetoothButtons extends StatefulWidget {
  const BluetoothButtons({Key? key}) : super(key: key);

  @override
  _BluetoothButtonsState createState() => _BluetoothButtonsState();
}

class _BluetoothButtonsState extends State<BluetoothButtons> {
  late String textError;

  @override
  Widget build(BuildContext context) {
    BluetoothController bluetooth = context.watch<BluetoothController>();

    bool initEnabled = (connected && enabled) ? true : false;

    Color connectColor = enabled ? enabledColor : disabledColor;
    Color initColor = initEnabled ? enabledColor : disabledColor;

    return Column(
      children: [
        Button(
          text: connectText,
          buttonColor: connectColor,
          textColor: textColor,
          onPressed: () async {
            if(enabled){
              bool isOn = await FlutterBlue.instance.isOn;

              if(!isOn){
                print('AAAAAAAAAA');
                showAlert(context, 'O bluetooth está desativado. Ative para conectar!');
              }

              else{
                setState(() {
                  enabled = false;

                  if(!connected){
                    connectText = 'conectando...';
                  }
                });

                bool connecting = connected ? false : true;
                await bluetooth.connectToDevice();

                if(connecting && !connected){
                  showAlert(context, 'Dispositivo não encontrado!');
                }

                setState(() {
                  connectText = connected ? 'desconectar' : 'conectar';
                  enabled = true;
                });
              }
            }

            else{
              setState(() {
                textError = connectText.contains('conectando') ? 'Conexão com o bluetooth em andamento!' : 'Processo em andamento!';
              });

              showAlert(context, textError);
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
        Button(
          text: 'ligar',
          buttonColor: initColor,
          textColor: textColor,
          onPressed: () async {
            if(initEnabled){
              enabled = false;
              await bluetooth.writeChar();
            }

            else{
              setState(() {
                textError = connected ? 'Processo em andamento!' : 'Bluetooth não conectado. Conecte-se com o bluetooth para iniciar!';
              });

              showAlert(context, textError);
            }
          },
        ),
      ],
    );
  }
}