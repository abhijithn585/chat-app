import 'package:chat_app/service/authentication_service.dart';
import 'package:chat_app/view/widget/custome_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PhoneLoginPage extends StatelessWidget {
  PhoneLoginPage({super.key});

  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController otpcontroller = TextEditingController();
  final AuthenticationService service = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              if (bottomInset > 0) {
                Scrollable.ensureVisible(
                  notification.context!,
                  alignmentPolicy:
                      ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
                );
              }
            }
            return true;
          },
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                // Lottie.asset(
                //   "assets/lottie/Animation - 1703063475434.json",
                //   height: 300,
                //   width: 300,
                // ),
                Center(
                  child: Text(
                    "OTP Verification",
                    style: GoogleFonts.ubuntu(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'We will send you a ',
                      style: GoogleFonts.montserrat(fontSize: 16),
                    ),
                    Text(
                      "One Time Password",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text("on your mobile number"),
                const SizedBox(height: 50),
                Column(
                  children: [
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: phonecontroller,
                            decoration: const InputDecoration(
                                hintText: '  phone', border: InputBorder.none)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: namecontroller,
                              decoration: const InputDecoration(
                                  hintText: '  Name',
                                  border: InputBorder.none)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: emailcontroller,
                              decoration: const InputDecoration(
                                  hintText: '  Email',
                                  border: InputBorder.none)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: InkWell(
                        splashColor: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          String countrycode = "+91";
                          String phonenumber =
                              countrycode + phonecontroller.text;
                          service.signInWithPhone(phonenumber, context,
                              namecontroller.text, emailcontroller.text);
                        },
                        child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 143, 157, 221)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            'Generate Otp',
                            style: GoogleFonts.ubuntu(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class PhoneLoginPage extends StatefulWidget {
//   const PhoneLoginPage({super.key});

//   @override
//   State<PhoneLoginPage> createState() => _PhoneLoginPageState();
// }

// class _PhoneLoginPageState extends State<PhoneLoginPage> {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   Country selectedCountry = Country(
//       phoneCode: "91",
//       countryCode: "IN",
//       e164Sc: 0,
//       geographic: true,
//       level: 1,
//       name: "India",
//       example: "India",
//       displayName: "India",
//       displayNameNoCountryCode: "IN",
//       e164Key: "");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Center(
//         child: Column(
//           children: [
//             Container(
//               width: 200,
//               height: 200,
//               decoration:
//                   BoxDecoration(shape: BoxShape.circle, color: Colors.black),
//               child: Image.asset('assets/phone verification.jpg'),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Register',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: Text(
//                 'Add your phone number , We' 'll send you a verification code',
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black45),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: 300,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.grey[200]),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                     controller: emailController,
//                     decoration: const InputDecoration(
//                         hintText: '  Email', border: InputBorder.none)),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: 300,
//               child: TextFormField(
//                 controller: phoneController,
//                 decoration: InputDecoration(
//                     hintStyle: TextStyle(fontWeight: FontWeight.bold),
//                     hintText: 'Enter phone number',
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: Colors.black12)),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: Colors.black12)),
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: Container(
//                         child: InkWell(
//                           onTap: () {
//                             showCountryPicker(
//                               context: context,
//                               countryListTheme:
//                                   CountryListThemeData(bottomSheetHeight: 500),
//                               onSelect: (value) {
//                                 setState(() {
//                                   selectedCountry = value;
//                                 });
//                               },
//                             );
//                           },
//                           child: Text(
//                             "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     )),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               style: ButtonStyle(
//                 fixedSize:
//                     MaterialStateProperty.all<Size>(const Size.fromWidth(200)),
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(const Color(0xFF688a74)),
//               ),
//               child: const Text(
//                 "Login",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
