import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/auth/veriffy_code_screen.dart';
import 'package:flutter_firebase_practice_thetechbrothers/utils/utils.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  final phoneController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Enter Your Phone Number',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purple),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
            SizedBox(height: 50),
            RoundButton(
              title: 'Login',
              loading: loading,

              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                  phoneNumber: phoneController.text.toString(),
                  verificationCompleted: (_) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e) {
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                  codeSent: (String verificationId, int? token) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VeriffyCodeScreen(verificationId: verificationId),
                      ),
                    );
                    setState(() {
                      loading = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
