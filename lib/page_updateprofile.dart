import 'dart:convert';

import 'package:bai_1/myaccount.dart';
import 'package:bai_1/profile.dart';
import 'package:flutter/material.dart';
import 'helper.dart';
import 'page_welcome.dart';
import 'package:http/http.dart' as http;

import 'token.dart';

class PageUpdateProfile extends StatefulWidget {
  const PageUpdateProfile({super.key});

  @override
  State<PageUpdateProfile> createState() => _PageUpdateProfileState();
}

class _PageUpdateProfileState extends State<PageUpdateProfile> {
  String first_name = "";
  String last_name = "";
  String email = "";
  String phone = "";
  String address = "";
  String mess_error = "";
  final _formkey = GlobalKey<FormState>();
  String? update_firstname(String? value) {
    first_name = value!;
    if (value.isEmpty == true) {
      setState(() {
        mess_error = "First name can not be empty";
      });
    }
    return null;
  }

  String? update_lastname(String? value) {
    last_name = value!;
    if (value.isEmpty == true && mess_error.isEmpty) {
      setState(() {
        mess_error = "Last name can not be empty";
      });
    }
    return null;
  }

  String? update_email(String? value) {
    email = value!;
    if (value.isEmpty == true && mess_error.isEmpty) {
      setState(() {
        mess_error = "Email can not be empty";
      });
    }
    return null;
  }

  String? update_address(String? value) {
    address = value!;
    if (value.isEmpty == true && mess_error.isEmpty) {
      setState(() {
        mess_error = "Address can not be empty";
      });
    }
    return null;
  }

  String? update_phone(String? value) {
    phone = value!;
    if (value.isEmpty == true && mess_error.isEmpty) {
      setState(() {
        mess_error = "Phone can not be empty";
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    createTextFormFieldUpdate(
                        'First Name', Profile.fisrt_name, update_firstname),
                    createTextFormFieldUpdate(
                        'Last Name', Profile.last_name, update_lastname),
                    createTextFormFieldUpdate(
                        'Phone', Profile.phone, update_phone),
                    createTextFormFieldUpdate(
                        'Email', Profile.email, update_email),
                    createTextFormFieldUpdate(
                        'Address', Profile.address, update_address),
                    Text(mess_error),
                    TextButton.icon(
                        onPressed: () {
                          if (_formkey.currentState?.validate() == true) {
                            _formkey.currentState?.save();
                            post_updatedetail(context);
                          }
                        },
                        icon: const Icon(Icons.app_registration_rounded),
                        label: const Text("Save")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void post_updatedetail(BuildContext context) {
    // debugPrint('trong phuong thuc debug');
    postUpdateDetail(context);
  }

  Future<void> postUpdateDetail(BuildContext context) async {
    final http.Response response = await http.patch(
      Uri.parse(Helper.linkUpdateProfile),
      headers: <String, String>{
        'Content-Type': 'aplication/json; charset=UTF-8',
        'Authorization': 'Bearer ' + Token.value,
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "first_name": first_name,
        "last_name": last_name,
        "phone": phone,
        "email": email,
        "address": address,
        "provinceid": '1',
        "provincename": '1',
        "districtid": '1',
        "districtname": '1',
        "wardid": '1',
        "wardname": '1',
        "street": address,
      }),
    );
    debugPrint('.. update detail ..');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if (response.statusCode == 200) {
      Helper.getProfile(context);
    } else {
      // throw Exception('Khong xac dinh loi trong dang ky');
    }
  }

  TextFormField createTextFormFieldUpdate(
      String label, String content, String? Function(String? value) f) {
    return TextFormField(
      onChanged: f,
      validator: f,
      initialValue: content,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
