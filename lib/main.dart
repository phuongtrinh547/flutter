import 'package:bai_1/page_updateavatar.dart';
import 'package:bai_1/page_updateprofile.dart';

import 'mainpage.dart';
import 'myaccount.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'helper.dart';
import 'page_register.dart';
// import 'page_welcome.dart';
import 'page_login.dart';
import 'product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo 1',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Bai1(),
    );
  }
}

class Bai1 extends StatelessWidget {
  const Bai1({super.key});
  void nextPage(BuildContext context, Widget page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const textStyleTitle =
        TextStyle(fontSize: 24.0, height: 1.4, color: Colors.orange);
    const textStyleCommand =
        TextStyle(fontSize: 20.0, height: 1.8, color: Colors.blueGrey);
    return Scaffold(
      appBar: AppBar(title: const Text("Ứng dụng bài 1")),
      body: Stack(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            width: size.width,
            height: size.height,
          ),
          // alignment: Alignment.topCenter,
          Container(
            height: 0.7 * size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment(0, 1),
                fit: BoxFit.cover,
                image: AssetImage("assets/images/flash_connection.png"),
              ),
            ),
            alignment: Alignment.center,
          ),
          Positioned(
            bottom: 0,
            width: size.width,
            child: Container(
              width: size.width,
              height: 0.3 * size.height,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(style: textStyleTitle, "Welcome"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Helper.newPage(context, const PageRegister());
                        },
                        icon: const Icon(
                          Icons.app_registration,
                          size: 20,
                        ),
                        label: const Text(style: textStyleCommand, "Register"),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Helper.newPage(context, const PageLogin());
                        },
                        icon: const Icon(
                          Icons.login,
                          size: 20,
                        ),
                        label: const Text(style: textStyleCommand, "Login"),
                      ),
                      // TextButton(
                      //     onPressed: null,
                      //     child: const Text(style: textStyleCommand, "Exit"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
