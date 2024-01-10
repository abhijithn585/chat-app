import 'package:chat_app/service/authentication_service.dart';
import 'package:chat_app/view/home_page.dart';
import 'package:chat_app/view/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationService authenticationService = AuthenticationService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 190),
                  child: Text(
                    'Go ahead and set up your account',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Sign in-up to enjoy',
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 165, 165, 165)),
                )
              ],
            ),
            color: Colors.black,
            height: 400,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]),
                    child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: '  Email', border: InputBorder.none)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]),
                    child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: '  Password', border: InputBorder.none)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(Size.fromWidth(200)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF688a74)),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200]),
                        child: IconButton(
                            onPressed: () {
                              authenticationService.signinWithGoogle();
                            },
                            icon: Icon(FontAwesomeIcons.google)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200]),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.phone)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200]),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.github)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account?",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'signUp',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;
    User? user =
        await authenticationService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print('there is some error ');
    }
  }
}
