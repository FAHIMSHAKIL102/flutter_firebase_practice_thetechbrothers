import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/firestore/add_firestore_screen.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  final fireStore = FirebaseFirestore.instance.collection('User');
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
              return ListTile(
                title: Text(asyncSnapshot.data!.docs[index]['title'].toString()),
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
}
