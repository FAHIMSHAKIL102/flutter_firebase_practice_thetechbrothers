import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/firestore/add_firestore_screen.dart';
import 'package:flutter_firebase_practice_thetechbrothers/utils/utils.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  final fireStore = FirebaseFirestore.instance.collection('User');
  final editFirestoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore')),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore.snapshots(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text('Error'));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final firestoreId = asyncSnapshot.data?.docs[index]['id']
                  .toString()??'';
              final firestoreTitle = asyncSnapshot.data?.docs[index]['title']
                  .toString()??'';
              return ListTile(
                onTap: () {
                  showFirestoreDialog(firestoreTitle, firestoreId);
                },
                title: Text(firestoreTitle),
                subtitle: Text(firestoreId),
                trailing: IconButton(
                  onPressed: () {
                    fireStore
                        .doc(firestoreId)
                        .delete()
                        .then((onValue) {
                          Utils().toastMessage('Delete');
                        })
                        .onError((handleError, stackTrace) {
                          Utils().toastMessage(handleError.toString());
                        });
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
            itemCount: asyncSnapshot.data!.docs.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFirestoreScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showFirestoreDialog(String title, String id) async {
     editFirestoreController.text=title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: TextField(controller: editFirestoreController),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fireStore
                    .doc(id)
                    .update({'title': editFirestoreController.text.toLowerCase()})
                    .then((onValue) {
                      Utils().toastMessage('Updated');
                    })
                    .onError((handleError, stackTrace) {
                      Utils().toastMessage(handleError.toString());
                    });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
