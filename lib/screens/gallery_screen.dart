import 'package:esrgan_flutter2_ocean_app/widgets/appbar_title.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: AppBarTitle(),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}