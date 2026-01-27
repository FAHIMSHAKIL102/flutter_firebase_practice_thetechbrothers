import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/auth/login_screen.dart';

class SplashService {
  void isLogin(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      ),
    );
  }
}
