import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chatservice {
  // get the instance of the auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
//get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

//create new message
    MessageModel newMessage = MessageModel(
        senderId: currentUserId,
        message: message,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        timestamp: timestamp);
//cunstruct chat room id from current user id and receiver id
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort the ids this ensure the chat room id is always the same for any pair of people
    String chatRoomId = ids.join('_');
// add new msg to firebase
    await _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toJson());
  }

  //get msg
  Stream<QuerySnapshot> getMessage(String userId, String OtherUserId) {
    List<String> ids = [userId, OtherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
