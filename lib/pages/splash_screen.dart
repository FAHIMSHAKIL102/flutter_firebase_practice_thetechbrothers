import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/firebase_service/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashScreen = SplashService();
  @override
  void initState() {
    super.initState();

    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Splash', style: TextStyle(fontSize: 50))),
    );
  }
}
