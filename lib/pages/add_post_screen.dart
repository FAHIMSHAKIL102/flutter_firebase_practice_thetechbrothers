import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/utils/utils.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  static const databaseURL =
      'https://fir-practicetechbrothers-default-rtdb.asia-southeast1.firebasedatabase.app';
  late final DatabaseReference databaseRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(), // Optional, if you have multiple Firebase apps
    databaseURL: databaseURL,
  ).ref("Post");
  bool loading = false;
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AddPost')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: postController,
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
                databaseRef
                    .child(id)
                    .set({'id': id, 'title': postController.text.toString()})
                    .then((onValue) {
                      Utils().toastMessage('Post');
                      setState(() {
                        loading = false;
                      });
                    })
                    .onError((handleError, stackTrace) {
                      Utils().toastMessage(handleError.toString());
                      setState(() {
                        loading = false;
                      });
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
