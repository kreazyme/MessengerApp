import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewChat extends StatefulWidget {
  const ViewChat({Key? key}) : super(key: key);

  @override
  State<ViewChat> createState() => _ViewChatState();
}

class _ViewChatState extends State<ViewChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Chat scren here")),
    );
  }
}
