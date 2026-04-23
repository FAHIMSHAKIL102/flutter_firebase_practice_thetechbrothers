import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No Image Picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getImage();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple),
                ),
                child: Center(
                  child: image != null
                      ? Image.file(image!.absolute)
                      : Icon(Icons.image, color: Colors.purple),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          RoundButton(title: 'Upload', onTap: () {}),
        ],
      ),
    );
  }
}
