import 'package:School_Dashboard/layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:get/get.dart';
import 'package:School_Dashboard/pages/authentication/confirmation.dart';
import 'package:School_Dashboard/pages/authentication/resetPassword.dart';
import 'package:School_Dashboard/pages/authentication/authentication.dart';
import 'package:School_Dashboard/pages/authentication/verifyEmail.dart';

String domain = "http://127.0.0.1:8000/";
List<String> schoolsList = [];
int userID;
String userName, email, code;
bool isSuperuser = true;

// value notifiers
ValueNotifier<String> totalParents = ValueNotifier("--");
ValueNotifier<String> totalStudents = ValueNotifier("--");
ValueNotifier<String> dismissalAverage = ValueNotifier("--");
ValueNotifier<String> dismissalMedian = ValueNotifier("--");
ValueNotifier<List<String>> gradeList = ValueNotifier(List.filled(12, "--"));

// get data functions

Future<void> getSchoolsList() async {
  Uri uri = Uri.parse(domain + "schools/");
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    for (var i = 0; i < jsonDecode(response.body).length; i++) {
      if (!schoolsList.contains(jsonDecode(response.body)[i])) {
        schoolsList.add(jsonDecode(response.body)[i]);
      }
    }
  }
}

Future<void> getUserSchool(int user_id) async {
  Uri uri = Uri.parse(domain + "schools/" + user_id.toString());
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    if (!schoolsList.contains(json.decode(response.body))) {
      schoolsList.add(json.decode(response.body));
    }
  }
}

Future<String> getTotalStudents(String schoolName) async {
  Uri uri = Uri.parse(domain + "schools/" + schoolName + "/students/total");
  final response = await http.get(uri);
  String studentsTotal;
  if (response.statusCode == 200) {
    studentsTotal = response.body;
  }
  return studentsTotal;
}

Future<String> getTotalParents(String schoolName) async {
  Uri uri = Uri.parse(domain + "schools/" + schoolName + "/parents/total");
  final response = await http.get(uri);
  String parentsTotal;
  if (response.statusCode == 200) {
    parentsTotal = response.body;
  }
  return parentsTotal;
}

Future<String> getDismissalAverage(String schoolName) async {
  Uri uri = Uri.parse(domain + "schools/" + schoolName + "/dismissal/average");
  final response = await http.get(uri);
  String dismissalAverage;
  if (response.statusCode == 200) {
    dismissalAverage = response.body;
  }
  return dismissalAverage;
}

Future<String> getDismissalMedian(String schoolName) async {
  Uri uri = Uri.parse(domain + "schools/" + schoolName + "/dismissal/median");
  final response = await http.get(uri);
  String dismissalMedian;
  if (response.statusCode == 200) {
    dismissalMedian = response.body;
  }
  return dismissalMedian;
}

Future<List<String>> getGradeList(String schoolName) async {
  Uri uri =
      Uri.parse(domain + "schools/" + schoolName + "/students/totalpergrade");
  final response = await http.get(uri);
  List<String> gradeList = [];
  if (response.statusCode == 200) {
    for (var i = 0; i < jsonDecode(response.body).length; i++) {
      if (!gradeList.contains(jsonDecode(response.body)[i])) {
        gradeList.add((jsonDecode(response.body)[i]).toString());
      }
    }
  }
  return gradeList;
}

Future<void> login(
    context, emailController, passwordController, rememberMe) async {
  // Send login request to API
  Uri uri = Uri.parse(domain + "auth/login");
  final response = await http.post(
    uri,
    body: {
      'email': emailController.text,
      'password': passwordController.text,
    },
  );
  final responseJson = json.decode(response.body);
  // Handle API response
  if (responseJson["status"] == "success") {
    // Login successful
    if (rememberMe) {
      // Save email and password
      html.window.localStorage['email'] = emailController.text;
      html.window.localStorage['password'] = passwordController.text;
    }
    if (responseJson["data"]["is_superuser"] == false) {
      isSuperuser = false;
    }
    userID = responseJson["data"]["id"];
    try {
      userName = responseJson["data"]["first_name"] +
          " " +
          responseJson["data"]["last_name"][0] +
          ".";
    } catch (e) {
      userName = responseJson["data"]["first_name"];
    }
    Get.offAll(() => SiteLayout());
  } else {
    // Login failed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid email or password')),
    );
  }
}

Future<void> logout() async {
  schoolsList = [];
  Get.offAll(() => AuthenticationPage());
}

void loadUserEmailPassword(
    emailController, passwordController, rememberMe) async {
  try {
    if (rememberMe) {
      var email = html.window.localStorage['email'];
      var password = html.window.localStorage['password'];
      emailController.text = email;
      passwordController.text = password;
    }
  } catch (e) {
    return;
  }
}

Future<void> sendVerificationCode(context, emailController) async {
  // send request to api
  Uri uri = Uri.parse(domain + "auth/send/code");
  email = emailController.text;
  final response = await http.put(
    uri,
    body: {
      'email': email,
    },
  );
  final responseJson = json.decode(response.body);
  // Handle API response
  if (responseJson["status"] == "success") {
    code = responseJson["data"];
    Get.offAll(() => VerifyEmailPage());
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'No user account found with this email. Please enter a valid email')),
    );
  }
}

Future<void> verifyCode(context, codeController) async {
  if (codeController.text == code) {
    Get.offAll(() => ResetPasswordPage());
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Invalid Code. Please re-check the email we sent you')),
    );
  }
}

Future<void> resetPassword(context, newpasswordController) async {
  // Send request to API
  Uri uri = Uri.parse(domain + "auth/reset/password");
  final response = await http.put(
    uri,
    body: {
      'email': email,
      'password': newpasswordController.text,
    },
  );
  final responseJson = json.decode(response.body);
  // Handle API response
  if (responseJson["status"] == "success") {
    Get.offAll(() => ConfirmationPage());
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Minimum eight and maximum 16 characters, at least one uppercase letter, one lowercase letter, one number and one special character')),
    );
  }
}
