import 'package:School_Dashboard/constants/style.dart';
import 'package:School_Dashboard/layout.dart';
import 'package:School_Dashboard/pages/authentication/forgotPassword.dart';
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

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => AuthenticationPageState();
}

class AuthenticationPageState extends State<AuthenticationPage> {
  @override
  void initState() {
    rememberMe = (html.window.localStorage['rememberMe'] == 'true');
    loadUserEmailPassword(emailController, passwordController, rememberMe);
    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isHidden = true;
  bool rememberMe = false;
  bool hover = false;
  
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
                      Text("Login",
                          style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "Welcome back to the School Dashboard.",
                        color: darkActive,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "abc@domain.com",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      controller: emailController,
                      onSubmitted: (value) => login(context, emailController,
                          passwordController, rememberMe)),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      obscureText: isHidden,
                      decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "123",
                          suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                                  isHidden 
                                  ? Icons.visibility 
                                  : Icons.visibility_off,
                                  color: Active,
                                  size: 20,
                    ),),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                      controller: passwordController,
                      onSubmitted: (value) => login(context, emailController,
                          passwordController, rememberMe)),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value;
                                });
                                html.window.localStorage['rememberMe'] =
                                    rememberMe.toString();
                              }),
                          CustomText(
                            text: "Remember me",
                          ),
                        ],
                      ),
                      InkWell(
                        hoverColor: contrast1,
                        onHover: (value) { if (value) {
                          setState(() {
                            hover = true;
                          });
                        } else {
                          setState(() {
                            hover = false;
                          });
                        }},
                          onTap: () {
                            // go to Reset Password page
                            Get.offAll(() => ForgotPasswordPage());
                            
                          },
                          child: CustomText(
                              text: "Forgot password?", color: hover ? contrast1 : Active)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      login(context, emailController, passwordController,
                          rememberMe);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Active,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CustomText(
                        text: "Login",
                        color: Colors.white,
                      ),
                    ),
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

