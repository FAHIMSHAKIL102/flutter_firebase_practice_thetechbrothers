import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Passwword',
                      suffixIcon: Icon(Icons.visibility_off),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RoundButton(
              title: 'Login',
              onTap: () {
                if (_formkey.currentState!.validate()) {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
