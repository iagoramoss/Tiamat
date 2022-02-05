import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './bluetooth.dart';
import './buttons.dart';
import './erlenmeyer.dart';
import './bubbles.dart';

class Tiamat extends StatefulWidget {
  const Tiamat({Key? key}) : super(key: key);

  @override
  _TiamatState createState() => _TiamatState();
}

class _TiamatState extends State<Tiamat> {
  final logo = SvgPicture.asset(
    'assets/logo.svg',
    width: 200,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TopUnderBubble(),
          const TopOverBubble(),
          const BottomUnderBubble(),
          const BottomOverBubble(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                logo,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Erlenmeyer(),
                        SizedBox(
                          height: 15,
                        ),
                        BluetoothButtons()
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 185,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}