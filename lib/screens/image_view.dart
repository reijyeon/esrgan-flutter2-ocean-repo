import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esrgan_flutter2_ocean_app/screens/trygallery.dart';
//import 'package:esrgan_flutter2_ocean_app/screens/gallery_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
//import 'package:gallery_saver/gallery_saver.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
final Reference storageRef = FirebaseStorage.instance.ref();
//final postsRef = Firestore.instance.collection('posts');

final postsRef = FirebaseFirestore.instance.collection('posts');
final DateTime timestamp = DateTime.now();
class ImageView extends StatefulWidget {

  final User user;
  final File image;
  final File orgImage;

  ImageView({required this.image, required this.orgImage, required this.user});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  double controller = 0.5;
  //List<StorageUploadTask> _tasks = <StorageUploadTask>[];

    Future<void> uploadImage() async {
    String postId = widget.user.uid +"_"+timestamp.toString().split(' ').join();
    UploadTask uploadTask =
        storageRef.child("post_$postId.jpg").putFile(widget.image);
    TaskSnapshot storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    //return downloadUrl;
    print(downloadUrl);
    createPostInFirestore(mediaUrl: downloadUrl);
    //Navigator.pushReplacement(context, newRoute)

    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Gallery(user: widget.user)));
  }

    createPostInFirestore(
      {required String mediaUrl,
      }) {
    postsRef
        .doc(widget.user.uid)
        .collection("userPosts")
        .doc(widget.user.uid +"_"+timestamp.toString().split(' ').join())
        .set({
      "imageId": widget.user.uid +"_"+timestamp.toString().split(' ').join(),
      "userId": widget.user.uid,
      "ownerId": widget.user.email,
      "mediaUrl": mediaUrl,
      "timestamp": timestamp,
    });
  }

 

  @override
  Widget build(BuildContext context) {
    TensorImage imgProp = TensorImage.fromFile(widget.image);
    
    
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
        title: Text('Result'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              //Navigator.pop(context);
              //Navigator.pop(context);
              //GallerySaver.saveImage(widget.image.path); //NEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEED 4 later
              //print('Saved');
              //showDialog(context: context, builder: (_) => imageSaved(context)); //NEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEED 4 later
              showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Save Image'),
          content: const Text('Do you want to save image?'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>  Navigator.of(context).pop(),//Navigator.pop(context, 'Cancel'),
              
              child: const Text('No', style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: uploadImage,//{

//                    //Navigator.of(context).push(Loadig)

//                     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoadingEnhanceScreen(user: widget._user, selectedImage: selectedImage!,)),
//   );
//                   //uploadImage(context);
                  
//                   //Navigator.pop(context, uploadImage(context));
                  
                  
              //},
              child: const Text('Yes'),
            ),
          ],
        ));
              
            },
          ),
        ],
      ),
      body: Stack(
        children: [
            //Container(child: Text("FDSFDSFSDFS", style: TextStyle(color: Colors.white),), ),
          Container(
            /*child: PhotoView(
              imageProvider: FileImage(image),
            ),*/
            //height: context.size.height,
            child: PhotoView.customChild(
              minScale: PhotoViewComputedScale.contained * 0.8,
              initialScale: PhotoViewComputedScale.contained,
              //basePosition: Alignment.centerRight,
              
              enableRotation: true,
              childSize:  Size(imgProp.width.toDouble(),imgProp.height.toDouble()),
              child: Container(
                child: Stack(
                  
                  children: [
                      
                    /*Image.file(
                      widget.orgImage, 
                      //height: imgProp.height.toDouble(), 
                      //width: imgProp.width.toDouble(),
                      alignment: Alignment.topLeft,
                    ),*/
                    Container(
                      height: imgProp.height.toDouble(),
                      width: imgProp.width.toDouble(),
                      child: Image.file(
                        widget.orgImage,
                        height: imgProp.height.toDouble(),
                        //width: imgProp.width.toDouble(),
                        alignment: Alignment.topLeft,
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 1),
                      height: imgProp.height.toDouble(),
                      width: imgProp.width.toDouble() * controller,
                      //margin: EdgeInsets.only(right: 5),
                      //color: Colors.black,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 4.0,
                            color: Colors.black
                          )
                        )
                      ),
                      child: Image.file(
                        widget.image, 
                        //height: imgProp.height.toDouble(), 
                        //width: imgProp.width.toDouble(), 
                        alignment: Alignment.topLeft,
                        fit: BoxFit.cover,
                        
                      ),
                    ),
                  
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            //alignment: Alignment.bottomCenter,
            left: 10,
            right: 10,
            bottom: 10,
            child: Slider(
            
              value: controller,
              min: 0.0,
              max: 1.0,

              //activeColor: Colors.redAccent[100],
              //inactiveColor: Colors.red[50],
              onChanged: (newVal){
                setState(() {
                  controller = newVal;
                });
              },
            ),
          ),
        ],
      )
    );
  }
}

AlertDialog imageSaved(context) {
  return AlertDialog(
    //title: Text(AppLocalizations.of(context).translate('msg_image_saved')),
    actions: [
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: Text('Ok'),
      ),
    ],
  );
}
