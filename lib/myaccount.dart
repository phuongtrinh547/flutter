import 'package:bai_1/page_updateavatar.dart';

import 'page_updateprofile.dart';
import 'profile.dart';
import 'package:flutter/material.dart';
import 'helper.dart';
import 'mainpage.dart';
import 'product.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("My Account")),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: size.width,
              height: 120,
              color: Colors.green,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40.0)),
                      child: Container(
                        height: 80,
                        width: 80,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/spinner.gif',
                          image: Profile.avatar,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Helper.nextPage(context, PageUpdateAvatar());
                      },
                      icon: const Icon(Icons.camera_alt_rounded),
                      label: const Text('change'),
                    ),
                  ]),
            ),
          ),
          Positioned(
            top: 120,
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 40, right: 20),
              width: size.width,
              // height: size.height,
              color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tên: ${Profile.first_name} ${Profile.last_name}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Số điện thoại: ${Profile.phone} '),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Email: ${Profile.email}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Địa chỉ: ${Profile.address} '),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 140,
            right: 10,
            child: TextButton.icon(
              onPressed: () {
                Helper.nextPage(context, PageUpdateProfile());
              },
              icon: const Icon(Icons.edit),
              label: const Text(''),
            ),
          ),
        ],
      ),
      bottomNavigationBar: createBottomNav(context),
    );
  }

  Container createBottomNav(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Helper.createBottomNaviItem("Home", Icons.home, () {
            Helper.newPage(context, const Mainpage());
          }),
          Helper.createBottomNaviItem("Products", Icons.library_books, () {
            Helper.newPage(context, const ProductPage());
          }),
          Helper.createBottomNaviItem("My account", Icons.account_box, () {}),
        ],
      ),
    );
  }
}
