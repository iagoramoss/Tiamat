import 'package:flutter/material.dart';

List<double> screenSizes = [];

class TopUnderBubble extends StatelessWidget {
  const TopUnderBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(screenSizes.isEmpty){
      screenSizes.addAll([MediaQuery.of(context).size.width, MediaQuery.of(context).size.height]);
    }

    return CustomPaint(
      size: const Size(158, 160),
      painter: TopUnderBubblePainter(),
    );
  }
}

class TopUnderBubblePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    var paint = Paint()
        ..color = const Color(0xffb4dfff);

    var path = topUnderBubblePath();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Path topUnderBubblePath(){
  return Path()
      ..moveTo(0, 0)
      ..lineTo(0, 150)
      ..quadraticBezierTo(30, 160, 100, 130)
      ..quadraticBezierTo(158, 100, 110, 0)
      ..close();
}

class TopOverBubble extends StatelessWidget {
  const TopOverBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 110),
      painter: TopOverBubblePainter(),
    );
  }
}

class TopOverBubblePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    var paint = Paint()
      ..color = const Color(0xffe7f9ff);

    var path = topOverBubblePath();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Path topOverBubblePath(){
  return Path()
    ..moveTo(60, 0)
    ..quadraticBezierTo(85, 65, 130, 60)
    ..quadraticBezierTo(170, 50, 185, 80)
    ..quadraticBezierTo(240, 110, 260, 0)
    ..close();
}

class BottomUnderBubble extends StatelessWidget {
  const BottomUnderBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: BottomUnderBubblePainter(),
    );
  }
}

class BottomUnderBubblePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    canvas.translate(screenSizes[0], screenSizes[1]);

    var paint = Paint()
      ..color = const Color(0xffb4dfff);

    var path = bottomUnderBubblePath();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Path bottomUnderBubblePath(){
  return Path()
      ..moveTo(0, 0)
      ..lineTo(-100, 0)
      ..quadraticBezierTo(-100, -60, 0, -100)
      ..close();
}

class BottomOverBubble extends StatelessWidget {
  const BottomOverBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: BottomOverBubblePainter(),
    );
  }
}

class BottomOverBubblePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    canvas.translate(screenSizes[0], screenSizes[1]);

    var paint = Paint()
      ..color = const Color(0xffe7f9ff);

    var path = bottomOverBubblePath();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Path bottomOverBubblePath(){
  return Path()
      ..moveTo(0, -25)
      ..quadraticBezierTo(-40, -50, -40, -82)
      ..quadraticBezierTo(-40, -120,  -80, -135)
      ..quadraticBezierTo(-115, -160, -100, -185)
      ..quadraticBezierTo(-95, -200, -60, -195)
      ..quadraticBezierTo(-30, -195, 0, -168)
      ..close();
}