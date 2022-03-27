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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  size: 28,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  radius: 50,
                  child: Image(image: NetworkImage(widget.url)),
                )),
          )
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    final data = docs[i].data();
                    String name = data['name'];
                    String ava = name.substring(0, 1);
                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              // shape: CircleBorder,

                              border: Border.all(
                                  width: 2, color: Colors.transparent),
                              color: Colors.purple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Center(
                            child: Text(
                              ava,
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38),
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w400),
                            ))
                      ]),
                    );
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
