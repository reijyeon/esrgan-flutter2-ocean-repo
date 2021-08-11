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
        home: LoginScreen(),
        debugShowCheckedModeBanner: true,
    );
  }
}