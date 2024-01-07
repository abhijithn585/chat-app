import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('some error');
    }
    return null;
  }

  Future<User?> signIpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('some error');
    }
  }

  signout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print('This is the erro r$e');
    }
  }
}
