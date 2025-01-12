import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/layout.dart';
import 'package:School_Dashboard/pages/authentication/authentication.dart';
import 'package:School_Dashboard/pages/authentication/resetPassword.dart';
import 'package:School_Dashboard/widgets/custom_text.dart';
import 'package:School_Dashboard/routing/routes.dart';
import 'package:School_Dashboard/data/school_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:async';
import 'dart:convert';

class VerifyEmailPage extends StatefulWidget {
  @override
  State<VerifyEmailPage> createState() => VerifyEmailPageState();
}

class VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController codeController = TextEditingController();
  bool hover2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login.jpg"),
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: <Color>[
                    Colors.white,
                    Colors.white
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  //tileMode: TileMode.mirror,
                ),
              ),
              constraints: BoxConstraints(maxWidth: 500),
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text("Verify Email",
                          style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "Enter the code sent to your email.",
                        color: darkActive,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Verification Code",
                          hintText: "Verification Code",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      controller: codeController,
                      onSubmitted: (value) => verifyCode(context, codeController)),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      verifyCode(context, codeController);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Active,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CustomText(
                        text: "Verify",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          hoverColor: contrast1,
                          onHover: (value) {
                            if (value) {
                              setState(() {
                                hover2 = true;
                              });
                            } else {
                              setState(() {
                                hover2 = false;
                              });
                            }
                          },
                          onTap: () {
                            // go to Reset Password page
                            Get.offAll(() => AuthenticationPage());
                          },
                          child: CustomText(
                              text: "Back to login page",
                              color: hover2 ? contrast1 : Active)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
