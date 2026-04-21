import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/utils/utils.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';

class AddFirestoreScreen extends StatefulWidget {
  const AddFirestoreScreen({super.key});

  @override
  State<AddFirestoreScreen> createState() => _AddFirestoreScreenState();
}

class _AddFirestoreScreenState extends State<AddFirestoreScreen> {
  bool loading = false;
  final addFirestoreController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('User');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Firestore')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: addFirestoreController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What is in your mind....',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            RoundButton(
              title: 'Add',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });

                String id = DateTime.now().millisecondsSinceEpoch.toString();
                fireStore
                    .doc(id)
                    .set({
                      'id': id,
                      'title': addFirestoreController.text.toString(),
                    })
                    .then((onValue) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage('Add');
                    })
                    .onError((handleError, StackTrace) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(handleError.toString());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
