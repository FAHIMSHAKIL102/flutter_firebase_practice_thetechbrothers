import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/add_post_screen.dart';
import 'package:flutter_firebase_practice_thetechbrothers/pages/auth/login_screen.dart';
import 'package:flutter_firebase_practice_thetechbrothers/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  static const databaseURL =
      'https://fir-practicetechbrothers-default-rtdb.asia-southeast1.firebasedatabase.app';
  late final DatabaseReference ref = FirebaseDatabase.instanceFor(
    app: Firebase.app(), // Optional, if you have multiple Firebase apps
    databaseURL: databaseURL,
  ).ref("Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Post'),
        actions: [
          IconButton(
            onPressed: () {
              auth
                  .signOut()
                  .then((onValue) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  })
                  .onError((handleError, stackTrace) {
                    Utils().toastMessage(handleError.toString());
                  });
            },
            icon: Icon(Icons.logout),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> list = [];
                  list.clear();
                  list = map.values.toList();
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final item = list[index];
                      final title = item['title']?.toString() ?? '';
                      final id = item['id']?.toString() ?? '';
                      return ListTile(
                        title: Text(title),
                        subtitle: Text(id),
                      );
                    },
                    itemCount: snapshot.data!.snapshot.children.length,
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Text('Loading'),
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                return ListTile(
                  title: Text(snapshot.child('title').value?.toString() ?? ''),
                  subtitle: Text(snapshot.child('id').value?.toString() ?? ''),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPostScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
