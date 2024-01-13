import 'package:chat_app/controller/firebase_provider.dart';
import 'package:chat_app/service/auth/authentication_service.dart';
import 'package:chat_app/view/chat_room/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        children: [
          Expanded(
            child: Consumer<FirebaseProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.users.length,
                  itemBuilder: (context, index) {
                    final userdetails = value.users[index];

                    if (userdetails.uid !=
                        FirebaseAuth.instance.currentUser?.uid) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              splashColor:
                                  const Color.fromRGBO(41, 15, 102, .3),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatScreen(user: userdetails),
                                  )),
                              child: ListTile(
                                // leading: const CircleAvatar(
                                //   radius: 35,
                                //   backgroundImage: AssetImage(
                                //     'assets/images/user.jpg',
                                //   ),
                                // ),
                                title: Text(
                                  userdetails.name ?? userdetails.email!,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: const Text(
                                  " Tap to Chat",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Divider(
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          )
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //build a list of users except for the current user
  // Widget buildUserList() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('error');
  //       } else if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator();
  //       } else {
  //         return ListView(
  //           children: snapshot.data!.docs
  //               .map<Widget>((doc) => buildUserListItem(doc))
  //               .toList(),
  //         );
  //       }
  //     },
  //   );
  // }

// // build individual user list items
//   Widget buildUserListItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
// //dispaly all users except current user
//     if (auth.currentUser!.email != data['email']) {
//       return ListTile(
//         title: Text(data['email']),
//         onTap: () {
//           //pass the clicked users uid to the chat page
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => ChatRoom(
//                 receiverUserEmail: data['email'], receiverUserId: data['uid']),
//           ));
//         },
//       );
//     } else {
//       return Container();
//     }
//   }
}
