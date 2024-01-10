import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<User?> signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //after creating the user , create a new doccument for the user in the users collection
      firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});
      return userCredential.user;
    } catch (e) {
      print('some error');
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      firestore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email},
          SetOptions(merge: true));
      return userCredential.user;
    } catch (e) {
      print('some error');
    }
    return null;
  }

  signinWithGoogle() async {
    try {
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gauth = await guser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken, idToken: gauth.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? googleuser = userCredential.user;
      final UserModel userdata = UserModel(
          name: googleuser!.displayName,
          email: googleuser.email,
          uid: googleuser.uid);
      firestore.collection('users').doc(googleuser.uid).set(userdata.toJson());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
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
