
// import 'package:intl/intl.dart';
// import 'package:blackfox/pages/activity_feed.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart'
//     as mdi;
// import '../models/user.dart';

// import '../pages/home.dart';




import 'package:flutter/material.dart';

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
//import 'package:esrgan_flutter2_ocean_app/widgets/scaler.dart';

//import '../widgets/progress.dart';
final Reference storageRef = FirebaseStorage.instance.ref();
final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection('posts');



class Post extends StatefulWidget {
  final String imageId;
  final String mediaUrl;
  final String ownerId;
  final Timestamp timestamp;
  final String userId;
  
  Post(
      {
           required this.imageId,
  required this.mediaUrl,
  required this.ownerId,
   required this.timestamp,
  required  this.userId
  
     });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      imageId: doc['imageId'],
      mediaUrl: doc['mediaUrl'],
      ownerId: doc['ownerId'],
      timestamp: doc['timestamp'],
      userId: doc['userId'],
    );
  }


  @override
  _PostState createState() => _PostState(
        ownerId: this.ownerId,
        timestamp: this.timestamp,
         imageId: this.imageId,
        userId:  this.userId,
        mediaUrl: this.mediaUrl,
      );
}

class _PostState extends State<Post> {
final String imageId;
  final String mediaUrl;
  final String ownerId;
  final Timestamp timestamp;
  final String userId;

  _PostState(
      {
   required this.imageId,
  required this.mediaUrl,
  required this.ownerId,
   required this.timestamp,
  required  this.userId
      });


  // Note: To delete post, ownerId and currentUserId must be equal, so they can be used interchangeably
 
  buildPostImage() {
    return GestureDetector(
      onDoubleTap: () => print('liking post'),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width:
                410.0, ////////////////////////////////////////////////////////////////////////
            height: 400.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black38, Colors.black38],
            )),

            child: Image.network(
              mediaUrl,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          color: Colors.grey[600],
        ),
        buildPostImage(),
      ],
    );
  }
}
