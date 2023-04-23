import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/providers/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashProvider splashProvider = Provider.of<SplashProvider>(context);
    splashProvider.init();
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
