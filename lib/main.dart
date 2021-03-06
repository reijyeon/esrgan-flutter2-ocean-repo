import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:esrgan_flutter2_ocean_app/screens/login_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(App());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          theme: ThemeData(
                  scaffoldBackgroundColor: Color(0xFF1f2430),
                  buttonTheme: ButtonThemeData(
                      buttonColor: Color(0xFF31a8ff)
                  ),
                  appBarTheme: AppBarTheme(color: Color(0xFF2F455C))
               ),
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
        debugShowCheckedModeBanner: false,
    );
  }
}


// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:esrgan_flutter2_ocean_app/prefs/style.dart';
// import 'package:esrgan_flutter2_ocean_app/prefs/theme_provider.dart';
// import 'package:esrgan_flutter2_ocean_app/screens/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(App());
// }
// class App extends StatefulWidget {

//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//     ThemeProvider themeProvider = ThemeProvider();
    
//     void getCurrentTheme() async {
//         themeProvider.darkTheme = await themeProvider.preference.getTheme();
//         }

//     @override
//     void initState() {
//         getCurrentTheme();
//         super.initState();
//         }

//     @override
//     Widget build(BuildContext context) {
//         return ChangeNotifierProvider(
//             create: (_) => themeProvider,
//             child: Consumer<ThemeProvider>(
//         builder: (context, value, child){
//             return MaterialApp(
//             theme: Style.themeData(themeProvider.darkTheme),
//             // theme: ThemeData(
//             //     appBarTheme: AppBarTheme(
//             //         color: Colors.white,
//             // )),
//             title: 'Esrgan Flutter',
//             home: AnimatedSplashScreen(
//             duration: 3000,
//             splash: 'assets/images/esrganFlutterLogo.png',
//             nextScreen: LoginScreen(),
//             splashTransition: SplashTransition.fadeTransition,
//             //pageTransitionType: PageTransitionType.scale,
//             backgroundColor: Colors.white,
//             splashIconSize: 300,
//             ),
//             debugShowCheckedModeBanner: true,
//         );
//         }
//         ));
//     }
// }


