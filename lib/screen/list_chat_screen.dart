import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({Key? key, required this.url, required this.username})
      : super(key: key);
  final String url;
  final String username;

  @override
  State<ListChatScreen> createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messenger nè"),
        // actions: [

        // ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(widget.username)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Text("Error while load data");
          }
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            if (docs.length == 0) {
              return Text("Dont have chat");
            }
            return Expanded(
              child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    final data = docs[i].data();
                    String name = data['name'];
                    String ava = name.substring(0, 1);
                    return Container(
                      child: Row(children: [
                        Text(
                          ava,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(name)
                      ]),
                    );
                  }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
