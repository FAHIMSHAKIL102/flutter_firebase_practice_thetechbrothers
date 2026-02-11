import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/post_screen.dart';
import 'package:flutter_firebase_practice_thetechbrothers/utils/utils.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';

class VeriffyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VeriffyCodeScreen({super.key, required this.verificationId});

  @override
  State<VeriffyCodeScreen> createState() => _VeriffyCodeScreenState();
}

class _VeriffyCodeScreenState extends State<VeriffyCodeScreen> {
  final verifyCodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verificcation')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              controller: verifyCodeController,
              decoration: InputDecoration(
                hintText: 'Enter 6 Digit Number',
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
              title: 'Verify',
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                  smsCode: verifyCodeController.text.toString(),
                  verificationId: widget.verificationId,
                );

                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostScreen()),
                  );
                } catch (e) {
                  Utils().toastMessage(e.toString());
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
