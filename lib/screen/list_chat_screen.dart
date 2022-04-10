import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kreazy_chat/screen/view_chart_screen.dart';
import 'package:kreazy_chat/value/colors.dart';

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
        backgroundColor: AppColors.mainColor,
        title: Text("Messenger nè"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearch());
                },
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
      body: Container(
        color: Colors.white,
        child: SizedBox(
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewChat()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  // shape: CircleBorder,

                                  border: Border.all(
                                      width: 2, color: Colors.transparent),
                                  color: ContactColors().RandomColor(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: Center(
                                child: Text(
                                  ava,
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ))
                          ]),
                        ),
                      );
                    });
              } else {
                return Text("Cannot load data");
              }
            },
          ),
        ),
      ),
    );
  }
}

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty == false) {
                query = "";
              }
            },
            icon: Icon(
              Icons.clear,
              size: 24,
            ))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
        Icons.arrow_back,
        size: 24,
      ));

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: TextStyle(fontSize: 30),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> ls;
    // if (query == null) {
    ls = <String>[query, "Trần Đức Thông"];
    // } else {
    // ls = <String>["Trần Đức Thông"];
    // }
    if (query == null) {
      return Container(
        child: Card(
          child: SizedBox(
            height: 60,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Trần Đức Thông",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      );
    } else {
      return TextButton(
          onPressed: () {},
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: SizedBox(
                    height: 60,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        ls[index],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                );
              },
              itemCount: ls.length));
    }
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
