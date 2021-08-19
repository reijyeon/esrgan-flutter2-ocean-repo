import 'package:flutter/material.dart';
//import '';
import '../screens/post_screen.dart';
import './custom_image.dart';
import './post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile(this.post);

  showPost(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostScreen(
          imageId: post.imageId, ///////////////////////SDDDDDDDDFFFdsfsdfsdfsdf
          userId: post.ownerId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPost(context),
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
