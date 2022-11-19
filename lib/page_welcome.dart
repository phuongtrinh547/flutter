import 'package:flutter/material.dart';
import 'dart:convert';
import 'helper.dart';
import 'package:http/http.dart' as http;
import 'page_register.dart';

class PageWelcome extends StatelessWidget {
  const PageWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page Welcome")),
      body: const Text("page welcome"),
    );
  }
}
