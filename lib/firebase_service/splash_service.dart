import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/auth/login_screen.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/post_screen.dart';

class SplashService {
  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if (user != null) {
      Timer(
        Duration(seconds: 2),
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostScreen()),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 2),
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        ),
      );
    }
  }
}
