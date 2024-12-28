import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dictionary_app/UI/appTheme.dart';
import 'package:flutter/material.dart';
import 'UI/screens/landingScreen.dart';
import 'package:dictionary_app/route.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: 'assets/8qiM.gif',
        nextScreen: DictionayScreen(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 300,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      //initialRoute: DictionayScreen.routeName,

      theme: appTheme,
      onGenerateRoute: CustomRoute.generateRoutes,
      builder: EasyLoading.init(),
    );
  }
}
