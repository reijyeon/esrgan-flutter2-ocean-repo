import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/esrganFlutterLogo.png",
          fit: BoxFit.fill,
          height: 65,
        ),
        Container(
            padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle'))
      ],
    );
  }
}
