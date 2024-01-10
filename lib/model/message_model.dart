import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  MessageModel(
      {required this.senderId,
      required this.message,
      required this.receiverId,
      required this.senderEmail,
      required this.timestamp});
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        senderId: json['senderId'],
        message: json['message'],
        receiverId: json['receiverId'],
        senderEmail: json['senderEmail'],
        timestamp: json['timestamp']);
  }
  Map<String, dynamic> toJson() {
    return {
      'senderEmail': senderEmail,
      'message': message,
      'receiverId': receiverId,
      'senderId': senderId,
      'timestamp': timestamp
    };
  }
}
