// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// class EnhanceScreen extends StatefulWidget {
//   const EnhanceScreen({ Key? key }) : super(key: key);

//   @override
//   _EnhanceScreenState createState() => _EnhanceScreenState();
// }

// class _EnhanceScreenState extends State<EnhanceScreen> {
//   var _image;
//   var imagePicker;
//   dynamic _pickImageError;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     imagePicker = new ImagePicker();
//   }

//   void _onImageButtonPressed(ImageSource source, BuildContext? context) async {
//     try {
//       XFile image = await imagePicker.pickImage(
//         source: source,
//         //maxWidth: maxWidth,
//         //maxHeight: maxHeight,
//         imageQuality: 100,
//       );
//       setState(() {
//         _image = File(image.path);
//       });
//     } catch (e) {
//       setState(() {
//         _pickImageError = e;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget btnChoosePhoto = ElevatedButton(
//       child: Text('Select Image'),
//       onPressed: () => _onImageButtonPressed(ImageSource.gallery, context),
//       style: ElevatedButton.styleFrom(
//         shape: new RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(30.0)),
//       ),
//     );

//     Widget showImage = Container(
//       width: double.infinity,
//       height: 400,
//       decoration: BoxDecoration(color: Colors.red[200]),
//       child: _image != null
//           ? Image.file(
//               _image,
//               width: 200.0,
//               height: 200.0,
//               fit: BoxFit.fitHeight,
//             )
//           : Container(
//               decoration: BoxDecoration(color: Colors.red[200]),
//               width: 200,
//               height: 200,
//               child: Icon(
//                 Icons.camera_alt,
//                 color: Colors.grey[800],
//               ),
//             ),
//     );

//       void pickImage() async {
//     File pickedImg = await ImagePicker.pickImage(source: ImageSource.gallery);
//     loadImage(pickedImg);
//     fetchResponse(pickedImg);
//   }

//   void fetchResponse(File image) async {
//     print('Fetch Response Called');

//     final mimeTypeData =
//         lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

//     final imageUploadRequest = http.MultipartRequest(
//         'POST', Uri.parse("http://35.223.166.50:8080/generate"));

//     final file = await http.MultipartFile.fromPath('image', image.path,
//         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

//     imageUploadRequest.fields['ext'] = mimeTypeData[1];
//     imageUploadRequest.files.add(file);
//     try {
//       final streamedResponse = await imageUploadRequest.send();
//       final response = await http.Response.fromStream(streamedResponse);
//       print(' Status Code: ${response.statusCode}');
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       String outputFile = responseData['result'];
//       displayResponseImage(outputFile);
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   void displayResponseImage(String outputFile) {
//     print("Updating Image");
//     outputFile = 'http://35.223.166.50:8080/download/' + outputFile;
//     setState(() {
//       imageOutput = Image(image: NetworkImage(outputFile));
//     });
//   }

//   void loadImage(File file) {
//     setState(() {
//       img1 = Image.file(file);
//     });
//   }

//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [showImage, btnChoosePhoto],
//         )),
//       ),
//     );
//   }
// }
