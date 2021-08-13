import 'dart:convert';
import 'dart:io';

import 'package:esrgan_flutter2_ocean_app/widgets/appbar_title.dart';
import 'package:esrgan_flutter2_ocean_app/widgets/scaler.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EnhanceScreen extends StatefulWidget {
  const EnhanceScreen({ Key? key }) : super(key: key);

  @override
  _EnhanceScreenState createState() => _EnhanceScreenState();
}

class _EnhanceScreenState extends State<EnhanceScreen> {
  File? selectedImage;
  String? message = "";

  uploadImage() async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.100.60:8080/upload"));

    final headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: "input"));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    setState(() {});
  }

  getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);
    print(selectedImage);
    setState(() {});
  }

  


  @override
  Widget build(BuildContext context) {
      ScreenScaler scaler = new ScreenScaler()..init(context);

      Widget imageBox = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      height: scaler.getHeight(40),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(children: [
              Container(child: Icon(FontAwesomeIcons.timesCircle, size: 40,)), 
              
               selectedImage == null
                ? Text("Please pick a imagfafasdfe to upload")
                 : Image.file(selectedImage!, width: double.infinity, ),
          ],)
          );

    Widget btnSelectImage = TextButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: getImage,
                icon: Icon(Icons.upload_file, color: Colors.white),
                label: Text("Select Image",
                    style: TextStyle(
                      color: Colors.white,
                        )));

    Widget btnEnhanceImage = TextButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: uploadImage,
                icon: Icon(Icons.upload_file, color: Colors.white),
                label: Text("Enhance Image",
                    style: TextStyle(
                      color: Colors.white,
                        )));

      return Scaffold(
        appBar: AppBar(
            title: AppBarTitle(),
        ),
        body: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                imageBox,
                btnSelectImage,
                btnEnhanceImage
            ],
            ),
        ),
    );
  }
}
