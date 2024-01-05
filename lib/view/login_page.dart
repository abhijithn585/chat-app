import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    child: TextFormField(
                        decoration: InputDecoration(
                      fillColor: Colors.grey[350],
                      filled: true,
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[350],
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
