import 'package:esrgan_flutter2_ocean_app/screens/image_super.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/screens/enhance_screen.dart';
import '/screens/gallery_screen.dart';
import '/screens/profile_screen.dart';
import '/authentication/authentication.dart';
import '/widgets/scaler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final filename = 'file.txt';
  final orgfilename = 'file.txt';
  late User _user;
  @override
  void initState() {
    _user = widget._user;
    createUserInFireStore();
    // TODO: implement initState
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler()..init(context);
    return buildAuthScreen();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
      //loadMarkerFeed();
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  Scaffold buildAuthScreen() {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          GalleryScreen(),
          //EnhanceScreen(),
          ImageSuperResolution(),
          ProfileScreen(
            user: _user,
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: onTap,
          selectedItemColor: Colors.blue,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey[400],
          selectedFontSize: scaler.getTextSize(8),
          unselectedFontSize: scaler.getTextSize(8),
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.images),
              label: ('Gallery'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magic),
              label: ('Enhance'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: ('Profile'),
            ),
          ]),
    );
  }

  createUserInFireStore() async {
    DocumentSnapshot doc = await usersRef.doc(_user.uid).get();
    if (!doc.exists) {
      usersRef.doc(_user.uid).set({
        "id": _user.uid,
        "photoUrl": _user.photoURL,
        "email": _user.email,
        "displayName": _user.displayName,
      });
    }
  }
}