import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/layout.dart';
import 'package:School_Dashboard/pages/authentication/authentication.dart';
import 'package:School_Dashboard/pages/authentication/confirmation.dart';
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

class ResetPasswordPage extends StatefulWidget {
  @override
  State<ResetPasswordPage> createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController newpasswordController = TextEditingController();
  bool hover2 = false;
  bool isHidden = true;

  void _togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

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
                      Text("Reset Password",
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
                        text: "Set your new password.",
                        color: darkActive,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      obscureText: isHidden,
                      decoration: InputDecoration(
                          labelText: "New Password",
                          hintText: "Minimum eight characters",
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Active,
                              size: 20,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      controller: newpasswordController,
                      onSubmitted: (value) =>
                          resetPassword(context, newpasswordController)),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      resetPassword(context, newpasswordController);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Active,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CustomText(
                        text: "Reset",
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
