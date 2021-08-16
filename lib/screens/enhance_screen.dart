import 'dart:convert';
import 'dart:io';

import 'package:esrgan_flutter2_ocean_app/screens/image_view.dart';
import 'package:esrgan_flutter2_ocean_app/screens/loading_enhance_screen.dart';
import 'package:esrgan_flutter2_ocean_app/widgets/appbar_title.dart';
import 'package:esrgan_flutter2_ocean_app/widgets/scaler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
class EnhanceScreen extends StatefulWidget {
  //const EnhanceScreen({ Key? key }) : super(key: key);

  const EnhanceScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _EnhanceScreenState createState() => _EnhanceScreenState();
}

class _EnhanceScreenState extends State<EnhanceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late User _user;
  File? selectedImage;
  File? upscaledImage;
  String? message = "";
  bool isEnhancing = false; 
  bool isEnhanced = false; 

   @override
  void initState() {
    _user = widget._user;
    super.initState();
  }



  getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);
    print(selectedImage);
    setState(() {});
  }

  void displayResponseImage(String outputFile) {
    print("Updating Image");
    outputFile = 'http://35.223.166.50:8080/download/' + outputFile;
    setState(() {
      upscaledImage = Image(image: NetworkImage(outputFile)) as File?;
    });
  }

//   Future<File> getImageFileFromAssets(Asset asset) async {
//     final byteData = await asset.getByteData();

//     final tempFile =
//         File("${(await getTemporaryDirectory()).path}/${asset.name}");
//     final file = await tempFile.writeAsBytes(
//       byteData.buffer
//           .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
//     );

//     return file;
//   }


//   Future<File> _fileFromImageUrl() async {
//     final response = await http.get('https://example.com/xyz.jpg' as Uri);

//     final documentDirectory = await getApplicationDocumentsDirectory();

//     final file = File(join(documentDirectory.path, 'imagetest.png'));

//     file.writeAsBytesSync(response.bodyBytes);

//     return file;
//   }

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
                    backgroundColor: MaterialStateProperty.all(selectedImage !=null? Colors.blue: Colors.blue[200])),
                              
                onPressed: ()=>
selectedImage !=null? 
                    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Enhance Image'),
          content: const Text('Do you want to enhance this selected image?'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.of(context).pop(),//Navigator.pop(context, 'Cancel'),
              
              child: const Text('No', style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: (){
                   //Navigator.of(context).push(Loadig)

                    Navigator.push(context,MaterialPageRoute(builder: (context) => LoadingEnhanceScreen(user: widget._user, selectedImage: selectedImage!,)),
  );
                  //uploadImage(context);
                  
                  //Navigator.pop(context, uploadImage(context));
                  
                  
              },
              child: const Text('Yes'),
            ),
          ],
        )) :  null,
                         
             
                icon: Icon(Icons.upload_file, color: Colors.white),
                label: Text("Enhance Image",
                    style: TextStyle(
                      color: Colors.white,
                        )));


     Widget body = Center(
            child: isEnhancing ? 
            Container(child: Text("HAHAHAHAAHAHAH"),) :
             Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                imageBox,
                btnSelectImage,
                btnEnhanceImage
            ],
            )
        );
 

      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: AppBarTitle(),
        ),
        body: body
    );
  }
}
