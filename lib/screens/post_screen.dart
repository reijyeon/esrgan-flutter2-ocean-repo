import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import './home.dart';
//import '../widgets/header.dart';
import '../widgets/post.dart';
import '../widgets/progress.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String imageId;

  PostScreen({required this.userId, required this.imageId});

  final postsRef = FirebaseFirestore.instance.collection('posts');
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsRef
          .doc(userId)
          .collection('userPosts')
          .doc(imageId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Post post = Post.fromDocument(snapshot.data as DocumentSnapshot<Object>);
        return Center(
          child: Scaffold(
            appBar: AppBar(
              //backgroundColor: Colors.grey[900],
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
