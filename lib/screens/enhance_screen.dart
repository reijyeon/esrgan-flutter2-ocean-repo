import 'package:esrgan_flutter2_ocean_app/widgets/appbar_title.dart';
import 'package:flutter/material.dart';

class EnhanceScreen extends StatefulWidget {
  const EnhanceScreen({Key? key}) : super(key: key);

  @override
  _EnhanceScreenState createState() => _EnhanceScreenState();
}

class _EnhanceScreenState extends State<EnhanceScreen> {
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