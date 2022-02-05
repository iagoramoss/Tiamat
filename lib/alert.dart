import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  final BuildContext context;
  final String msg;
  
  const Alert({Key? key, required this.context, required this.msg}) : super(key: key);

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> with SingleTickerProviderStateMixin{
  late AnimationController controller;

  @override
  void initState(){
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 350),
    );

    controller.forward();
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: AlertDialog(
        title: const Text('Erro!'),
        content: Text(widget.msg),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: (){
              Navigator.of(widget.context).pop();
            },
          ),
        ],
      ),
    );
  }
}


void showAlert(BuildContext context, String msg){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return Alert(context: context, msg: msg);
    }
  );
}