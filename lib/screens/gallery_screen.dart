//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esrgan_flutter2_ocean_app/widgets/appbar_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:esrgan_flutter2_ocean_app/widgets/scaler.dart';
//import '../models/user.dart';

import '../widgets/post.dart';
import '../widgets/post_tile.dart';
import '../widgets/progress.dart';

//final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection('posts');
class Gallery extends StatefulWidget {
  //final String GalleryId;

  Gallery({required this.user});

   final User user;
//   final File image;
//   final File orgImage;

//   ImageView({required this.image, required this.orgImage, required this.user});

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  //final String currentUserId = currentUser?.id;
  String postOrientation = "grid";
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    getGalleryPosts();
  }

  getGalleryPosts() async {
    setState(() {
      isLoading = true;
    });

//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("collection").getDocuments();
//   for (int i = 0; i < querySnapshot.documents.length; i++) {
//     var a = querySnapshot.documents[i];
//     print(a.documentID);
//   }
    QuerySnapshot snapshot = await postsRef
        .doc(widget.user.uid)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .get();
        //.getDocuments();
    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  buildGalleryHeader() {
    //ScreenScaler scaler = ScreenScaler()..init(context);
    // return FutureBuilder(
    //   future: usersRef.document(widget.GalleryId).get(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return circularProgress();
    //     }
    //     User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Column(children: <Widget>[
                ClipOval(
                      child: Material(
                        color: Colors
                            .blue, //CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Image.network(
                          widget.user.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    widget.user.displayName!.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.grey[100]),
                  ),
                ),
              ]),
              //SizedBox(height: scaler.getHeight(2)),
            ],
          ),
        );
  }

  buildGalleryPosts() {
    if (isLoading) {
      return circularProgress();
    } else if (postOrientation == "grid") {
      List<GridTile> gridTiles = [];
      posts.forEach((post) {
        gridTiles.add(GridTile(child: PostTile(post)));
      });
      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.5,
        crossAxisSpacing: 1.5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTiles,
      );
    } else if (postOrientation == "list") {
      return Column(
        children: posts,
      );
    }
  }

  setPostOrientation(String postOrientation) {
    setState(() {
      this.postOrientation = postOrientation;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar,
      backgroundColor: Color(0xFF1c222e),
      drawer: customAppBar,
      body: ListView(
        children: <Widget>[
          buildGalleryHeader(),
          Divider(color: Colors.grey,),
          buildGalleryPosts(),
        ],
      ),
    );
  }
}
