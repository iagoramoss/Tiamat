import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './bluetooth.dart';
import './home.dart';

class Screen extends StatefulWidget{
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    final AnimationController _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 7050),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
                'assets/splash_screen.json',
                animate: true,
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController
                    ..duration = composition.duration
                    ..forward().whenComplete(() =>
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Tiamat()),
                        ));
                }
            ),
            const SizedBox(
              height: 180,
            ),
          ],
        ),
      ),
    );
  }
}

class Load extends StatefulWidget {
  const Load({Key? key}) : super(key: key);

  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load>{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BluetoothController(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Screen(),
      ),
    );
  }
}


Future<void> loadLogo() async{
  WidgetsFlutterBinding.ensureInitialized();

  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoderBuilder,
          'assets/logo.svg',
      ),
      null
  );
}
