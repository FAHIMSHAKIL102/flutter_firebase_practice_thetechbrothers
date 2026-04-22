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
  final searchFilterController = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Post'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {
              auth
                  .signOut()
                  .then((onValue) {
                    Navigator.pushReplacement(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchFilterController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Center(
                child: Text(
                  'Loading',
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
              ),
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value?.toString() ?? '';
                final id = snapshot.child('id').value?.toString() ?? '';
                if (searchFilterController.text.isEmpty) {
                  return ListTile(
                    title: Text(title),
                    subtitle: Text(id),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog(title, id);
                            },
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              ref
                                  .child(id
                                  )
                                  .remove();
                            },
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (title.toLowerCase().contains(
                  searchFilterController.text.toLowerCase().toString(),
                )) {
                  return ListTile(
                    title: Text(title),
                    subtitle: Text(
                      snapshot.child('id').value?.toString() ?? '',
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
           ),
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
                      return ListTile(title: Text(title), subtitle: Text(id));
                    },
                    itemCount: snapshot.data!.snapshot.children.length,
                  );
                }
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

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: TextField(controller: editController),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref
                    .child(id)
                    .update({
                      'title': editController.text.toLowerCase(),
                    })
                    .then((onValue) {
                      Utils().toastMessage('Post Updated');
                    })
                    .onError((handleError, stackTrace) {
                      Utils().toastMessage(handleError.toString());
                    });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
