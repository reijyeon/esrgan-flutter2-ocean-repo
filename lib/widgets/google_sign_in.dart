// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '/screens/home_screen.dart';
// import '/authentication/authentication.dart';

// class GoogleSignInButton extends StatefulWidget {
//   @override
//   _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
// }

// class _GoogleSignInButtonState extends State<GoogleSignInButton> {
//   bool _isSigningIn = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 1.0),
//       child: _isSigningIn
//           ? CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             )
//           : Container(
//               padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
//               child: ElevatedButton.icon(
//                   onPressed: () async {
//                     setState(() {
//                       _isSigningIn = true;
//                     });
//                     User? user =
//                         await Authentication.signInWithGoogle(context: context);

//                     setState(() {
//                       _isSigningIn = false;
//                     });

//                     if (user != null) {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (context) => HomeScreen(
//                             user: user,
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                       shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(30.0),
//                       ),
//                       primary: Colors.white,
//                       onPrimary: Colors.blue[500],
//                       minimumSize: Size(double.infinity, 50)),
//                   icon: FaIcon(
//                     FontAwesomeIcons.google,
//                   ),
//                   label: Text(
//                     'Sign up with Google',
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                   )),
//             ),
//     );
//   }
// }