import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:esrgan_flutter2_ocean_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  color: Colors.white,
               )),
        title: 'Esrgan Flutter',
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: 'assets/images/esrganFlutterLogo.png',
          nextScreen: LoginScreen(),
          splashTransition: SplashTransition.fadeTransition,
          //pageTransitionType: PageTransitionType.scale,
          backgroundColor: Colors.white,
          splashIconSize: 300,
        ),
        debugShowCheckedModeBanner: true,
    );
  }
}