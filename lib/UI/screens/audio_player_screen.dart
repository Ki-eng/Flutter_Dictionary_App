import 'package:dictionary_app/constants/appStrings.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatelessWidget {
  static const String routeName = '/audioPlayer';

  AudioPlayerScreen({required this.url});

  final String? url;

  final _player = AudioPlayer();

  void playAudio() async {
    try {
      if (url != null) {
        await _player.setUrl(
          url!,
        );
        await _player.play();
      }
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Appstrings.playAudio),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: playAudio,
            child: Icon(
              Icons.play_arrow,
              size: 100,
              color: Colors.blue,
            ),
          ),
          Center(
            child: Text(
              Appstrings.play,
              style: TextStyle(
                fontSize: 26,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
