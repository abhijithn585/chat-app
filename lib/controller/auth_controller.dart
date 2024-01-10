import 'package:chat_app/service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProviders extends ChangeNotifier {
  Future<UserCredential>? user;
  AuthenticationService service = AuthenticationService();
}
