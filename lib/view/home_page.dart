import 'package:chat_app/service/authentication_service.dart';
import 'package:chat_app/view/chat_room.dart';
import 'package:chat_app/view/onboarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthenticationService().signout();
              print('signout');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: buildUserList(),
    );
  }

  //build a list of users except for the current user
  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => buildUserListItem(doc))
                .toList(),
          );
        }
      },
    );
  }

// build individual user list items
  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//dispaly all users except current user
    if (auth.currentUser?.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          //pass the clicked users uid to the chat page
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatRoom(
                receiverUserEmail: data['email'], receiverUserId: data['uid']),
          ));
        },
      );
    } else {
      return Container();
    }
  }
}
