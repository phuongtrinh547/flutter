import 'dart:convert';
// import 'dart:html';
// import 'dart:io';
import 'mainpage.dart';
import 'package:flutter/material.dart';
import 'helper.dart';
// import 'page_welcome.dart';
import 'package:http/http.dart' as http;
import 'token.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page Login")),
      body: const LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _PageLoginState();
}

class _PageLoginState extends State<LoginBody> {
  String username = "";
  String password = "";
  // ignore: non_constant_identifier_names
  String mess_error = "";
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(children: [
            createTextFormField("Username", "username for login",
                "Username must not be empty", "username"),
            createTextFormField("Password", "password for login",
                "Password must not be empty", "password"),
            Text(
              mess_error,
              style: TextStyle(color: Colors.red),
            ),
            TextButton.icon(
                onPressed: () {
                  post_login(context, username, password);
                  // if (_formkey.currentState?.validate() == true) {
                  //   _formkey.currentState?.save();
                  //   post_login(context);
                  // }
                },
                icon: const Icon(Icons.login_rounded),
                label: const Text("Login")),
          ]),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void post_login(BuildContext context, String username, String password) {
    debugPrint('trong phuong thuc debug');
    postLogin(context, username, password);
  }

  Future<void> postLogin(
      BuildContext context, String username, String pass) async {
    final http.Response response = await http.post(
      Uri.parse(Helper.linkLogin),
      headers: <String, String>{
        'Content-Type': 'aplication/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": pass,
        "device_name": "app",
      }),
    );
    debugPrint('trong phuong thuc dang nhap');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if (response.statusCode == 200) {
      Token.fromJson(jsonDecode(response.body));
      Helper.token = Token.value;
      debugPrint(Helper.token);
      Helper.newPage(context, Mainpage());
    } else {
      // throw Exception('Khong xac dinh loi trong dang nhap');
    }
  }

  TextFormField createTextFormField(
      String label, String hint, String error, String saveValue) {
    return TextFormField(
      onChanged: (value) => {
        setState(() {
          if (saveValue == "username") username = value;
          if (saveValue == "password") password = value;
        })
      },
      validator: (value) {
        String temp = value!;
        if (saveValue == "username") username = value;
        if (saveValue == "password") password = value;
        if (temp.isEmpty == true) {
          setState(() {
            mess_error = error;
          });
          return '';
        } else {
          setState(() {
            mess_error = "";
          });
        }
        return null;
      },
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
