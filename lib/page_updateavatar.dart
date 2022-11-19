import 'dart:io';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'helper.dart';
import 'token.dart';

class PageUpdateAvatar extends StatefulWidget {
  const PageUpdateAvatar({super.key});

  @override
  State<PageUpdateAvatar> createState() => _PageUpdateAvatarState();
}

class _PageUpdateAvatarState extends State<PageUpdateAvatar> {
  late Future<XFile?> file;
  late final XFile? tmpFile;
  final ImagePicker _picker = ImagePicker();
  late Widget final_image;
  void chooseImage() {
    setState(() {
      file = _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 50,
      );
    });
  }

  Widget showImage() {
    return FutureBuilder<XFile?>(
        future: file,
        builder: (BuildContext context, AsyncSnapshot<XFile?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              null != snapshot.data) {
            tmpFile = snapshot.data;
            final_image = Column(
              children: [
                Image.file(File(tmpFile!.path())),
                TextButton.icon(
                  onPressed: () {
                    start_upload();
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('save'),
                )
              ],
            );
            return final_image;
          } else {
            return Text("no image");
          }
        });
  }

  @override
  void initState() {
    chooseImage();
    super.initState();
  }

  void start_upload() {
    if (tmpFile != null) {
      String filename = tmpFile!.path().split('/').last;
    }
  }

  Future<void> upload(String filename) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Helper.linkUploadavatar));
    Map<String, String> headers = {
      "Accept": "Application/json",
      "Content-Type": "mutipart/form_data",
      "Authorization": "Bearer " + Token.value,
    };
    request.headers.addAll(headers);
    final imageBytes = await tmpFile?.readAsBytes();
    final compressedImageBytes =
        await FlutterImageCompress.compressWithList(imageBytes);
    request.files.add(http.MultipartFile.fromBytes('file', compressedImageBytes,
        filename: filename));
    var response = await request.send();
    print(response.statusCode);
    final res = await http.Response.fromStream(response);
    print(res.body);
    // var data = json.decode(res.body);
    if (response.statusCode == 200) {
      Helper.getProfile(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Avatar"),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton.icon(
              onPressed: chooseImage,
              icon: Icon(Icons.camera_enhance_rounded),
              label: Text("choose image"),
            ),
            showImage(),
          ],
        ),
      ),
    );
  }
}
