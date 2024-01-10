import 'package:chat_app/service/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  const ChatRoom(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController messageController = TextEditingController();
  final Chatservice chatservice = Chatservice();
  final FirebaseAuth firebaseaAuth = FirebaseAuth.instance;
  void sendMessage() async {
    //only send if there anyting to send
    if (messageController.text.isNotEmpty) {
      await chatservice.sendMessage(
          widget.receiverUserId, messageController.text);
      //clear the text controller after sending the message
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          //user input
          buildMessageInput(),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: chatservice.getMessage(
          widget.receiverUserId, firebaseaAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    // align the messages
    var alignment = (data['senderId'] == firebaseaAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [Text(data['senderEmail']), Text(data['message'])],
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: messageController,
        ))
      ],
    );
  }
}
