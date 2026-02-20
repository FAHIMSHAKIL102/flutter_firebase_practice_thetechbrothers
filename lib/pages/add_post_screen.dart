import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AddPost')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(hintText: 'What is in your mind....'),
            ),
            SizedBox(height: 40),
            RoundButton(title: 'Add', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
