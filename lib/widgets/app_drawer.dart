import 'package:flutter/material.dart';

class CustomAppDawer extends StatelessWidget {
  const CustomAppDawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
                  child: Container(
                //color: customAppTheme.bgLayer1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        //padding: Spacing.only(left: 16, bottom: 24, top: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("./assets/brand/flutkit.png"),
                              height: 102,
                              width: 102,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    
                    // Container(
                    //   color: customAppTheme.bgLayer1,
                    //   child: ListTile(
                    //     onTap: () {
                    //       showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) =>
                    //               SelectThemeDialog());
                    //     },
                    //     title: Text(
                    //       "Select Theme",
                    //       style: AppTheme.getTextStyle(
                    //           themeData.textTheme.subtitle2,
                    //           fontWeight: 600),
                    //     ),
                    //     trailing: Icon(Icons.chevron_right,
                    //         color: themeData.colorScheme.onBackground),
                    //   ),
                    // ),
                    Divider(),

  
                         
                            //Space.height(16),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    //_launchURL();
                                  },
                                  child: Text("Buy Now")),
                            )
                  ],
                ),
              )
      
    );
  }
}

