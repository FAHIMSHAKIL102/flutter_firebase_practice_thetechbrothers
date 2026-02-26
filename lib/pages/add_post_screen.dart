import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

static const databaseURL = 'https://fir-practicetechbrothers-default-rtdb.asia-southeast1.firebasedatabase.app';
late final DatabaseReference databaseRef = FirebaseDatabase.instanceFor(
  app: Firebase.app(), // Optional, if you have multiple Firebase apps
  databaseURL: databaseURL,
).ref("your_data_path");
  bool loading = false;
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AddPost')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
              onTap: () {
                databaseRef.child('1').set({
                  'title': postController.text.toString()
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
