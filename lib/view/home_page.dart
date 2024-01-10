import 'package:chat_app/service/authentication_service.dart';
import 'package:chat_app/view/login_page.dart';
import 'package:chat_app/view/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: GestureDetector(
          child: Text('Sign Out'),
          onTap: () async {
            await AuthenticationService().signout();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => OnBoarding()));
          },
        ),
      ),
    );
  }
}
