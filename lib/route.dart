import 'package:dictionary_app/UI/screens/audio_player_screen.dart';
import 'package:dictionary_app/UI/screens/landingScreen.dart';
import 'package:flutter/material.dart';

abstract class CustomRoute {
  static Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AudioPlayerScreen.routeName:
        final String url = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => AudioPlayerScreen(url: url));
      default:
        return MaterialPageRoute(builder: (_) => DictionayScreen());
    }
  }
}
