import 'dart:convert';

import 'myaccount.dart';
import 'page_welcome.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'profile.dart';
import 'token.dart';

class Helper {
  static String linkRegister = "https://chocaycanh.club/public/api/register";
  static String linkLogin = "https://chocaycanh.club/public/api/login";
  static String linkProfile = "https://chocaycanh.club/public/api/me";
  static String linkUpdateProfile =
      "https://chocaycanh.club/public/api/me/details";
  static String linkUploadavatar =
      "https://chocaycanh.club/public/api/me/avatar";
  static String token = "";
  static Widget createBottomNaviItem(
      String title, IconData icon, Function() press) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  static void nextPage(BuildContext context, Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  static void newPage(BuildContext context, Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  static void newUniquePage(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

  static Future<void> postSignup(
      BuildContext context, String username, String mail, String pass) async {
    final http.Response response = await http.post(
      Uri.parse(linkRegister),
      headers: <String, String>{
        'Content-Type': 'aplication/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "email": mail,
        "password": pass,
        "password_confirmation": pass,
        "tos": 'true',
      }),
    );
    debugPrint('trong phuong thuc dang nhap');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Helper.nextPage(context, const PageWelcome());
    } else {
      // throw Exception('Khong xac dinh loi trong dang ky');
    }
  }

  static Future<void> getProfile(BuildContext context) async {
    final http.Response response = await http.get(
      Uri.parse(linkProfile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + Token.value,
        'Accept': 'application/json',
      },
    );
    debugPrint('.. get profile ..');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Profile.fromJson(body["data"]);
      Helper.newUniquePage(context, MyAccountPage());
    } else {
      // throw Exception('Khong xac dinh loi trong dang ky');
    }
  }
}
