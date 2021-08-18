import 'package:esrgan_flutter2_ocean_app/prefs/style.dart';
import 'package:esrgan_flutter2_ocean_app/prefs/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class AccountScreen extends StatefulWidget {

  const AccountScreen({Key? key, required User user})
  : _user = user,
  super(key: key);

  final User _user;

  static const keyDarkMode = 'key-dark-mode';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
    bool switchValue = false;
  ThemeProvider themeProvider = ThemeProvider();

  @override
    Widget buildDarkMode() => SwitchSettingsTile(
        settingKey: AccountScreen.keyDarkMode,
        title: 'Dark Mode',
        subtitle: '',
        leading: MaterialButton(
            onPressed: () {},
            color: Colors.purple[600],
            child: Icon(
                Icons.dark_mode,
                color: Colors.white,
                //size: 24,
                ),
            //padding: EdgeInsets.all(16),
            shape: CircleBorder(),
            ),
        //Icon(FontAwesomeIcons.signOutAlt, color: Colors.blue,),
        onChange: (_) {},
        );

    Widget buildLogout() => SimpleSettingsTile(
        title: 'Logout',
        subtitle: '',
        leading: MaterialButton(
            onPressed: () {},
            color: Colors.blue,
           
            child: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
                //size: 24,
                ),
            //padding: EdgeInsets.all(16),
            shape: CircleBorder(),
            ),
        //Icon(FontAwesomeIcons.signOutAlt, color: Colors.blue,),
        onTap: ()=> null,
        );

    Widget buildDeleteAccount() => SimpleSettingsTile(
            title: 'Delete Account',
            subtitle: '',
            leading: MaterialButton(
                onPressed: () {},
                color: Colors.red,
                child: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.white,
                    //size: 24,
                    ),
                //padding: EdgeInsets.all(16),
                shape: CircleBorder(),
                ),
            //Icon(FontAwesomeIcons.signOutAlt, color: Colors.blue,),
            onTap: ()=> null,
            );
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child){
          return MaterialApp(
            theme: Style.themeData(themeProvider.darkTheme),
            home: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Toggle DarkTheme'
                ),
              ),
              body: Center(
                child: Switch(
                  value: switchValue,
                  onChanged: (val){
                    themeProvider.darkTheme = !themeProvider.darkTheme;
                    setState(() {
                      switchValue = val;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(child: ListView(
//             children: [
//                Switch(
//                   value: switchValue,
//                   onChanged: (val){
//                     themeProvider.darkTheme = !themeProvider.darkTheme;
//                     setState(() {
//                       switchValue = val;
//                     });
//                   },
//                 ),
//             ],
//         )),
//     );
//   }
}