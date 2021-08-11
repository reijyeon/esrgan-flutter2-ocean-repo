import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class ImageSuperResolution extends StatefulWidget {
  @override
  _ImageSuperResolutionState createState() => _ImageSuperResolutionState();
}

class _ImageSuperResolutionState extends State<ImageSuperResolution> {
var imagePicker;
File? _showImage;
  var img1 = Image.asset(
    'assets/images/place_holder_image.jpg',
    fit: BoxFit.contain,
  );

  Widget imageOutput = Image.asset('assets/images/place_holder_image.jpg');
  @override
  void initState() {
    // TODO: implement initState
    imagePicker = new ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Image Super Resolution')),
        body: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  buildImageInput(),
                  buildImageOutput(),
                  buildPickImageButton(),
                  buildUploadImageButton()
                ])));
  }

  var url =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';


  Widget buildImageInput() {
    return Expanded(
      child: Container(
        width: 200, 
        height: 200, 
        child: img1
      )
    );
  }

    Widget buildImageOutput() {
    return Expanded(
        child: Container(
            width: 200, 
            height: 200, 
            child: imageOutput
          )
    );
  }

  Widget buildPickImageButton() {
    return Container(
        margin: EdgeInsets.all(8),
        child: FloatingActionButton(
          elevation: 8,
          onPressed: () => pickImage(),
          child: Icon(Icons.camera_alt),
        ));
  }

  Widget buildUploadImageButton() {
    return Container(
        margin: EdgeInsets.all(8),
        child: FloatingActionButton(
          elevation: 8,
          onPressed: () => fetchResponse(_showImage!),
          child: Icon(Icons.add_box),
        ));
  }

  void pickImage() async {
      //NEW
       XFile selectedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        //maxWidth: maxWidth,
        //maxHeight: maxHeight,
        imageQuality: 100,
      );

       setState(() {
        _showImage = File(selectedImage.path);
      });
      loadImage(_showImage!);
    // } catch (e) {
    //   setState(() {
    //     _pickImageError = e;
    //   });
    // }

    //ORIG
    // File pickedImg = await ImagePicker.pickImage(source: ImageSource.gallery);
    // loadImage(pickedImg);
    // fetchResponse(pickedImg);
  }

  void fetchResponse(File image) async {
    print('Fetch Response Called');

    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])!.split('/');

    final imageUploadRequest = http.MultipartRequest(
        'POST', Uri.parse("http://192.168.100.60:8080/generate"));

    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(' Status Code: ${response.statusCode}');
      final Map<String, dynamic> responseData = json.decode(response.body);
      String outputFile = responseData['result'];
      displayResponseImage(outputFile);
    } catch (e) {
      print(e);
      return null;
    }
  }

  void displayResponseImage(String outputFile) {
    print("Updating Image");
    outputFile = 'http://192.168.100.60:8080/download/' + outputFile;
    setState(() {
      imageOutput = Image(image: NetworkImage(outputFile));
    });
  }

  void loadImage(File file) {
    setState(() {
      img1 = Image.file(file);
    });
  }
}
