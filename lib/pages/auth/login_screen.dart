import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          TextFormField(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RoundButton(title: 'Login', onTap: () {}),
          ),
        ],
      ),
    );
  }
}
