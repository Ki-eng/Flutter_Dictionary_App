import 'package:dictionary_app/constants/error_strings.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_app/constants/appStrings.dart';
import 'package:dictionary_app/data/word.dart';

class Meaningcard extends StatelessWidget {
  Meaningcard({required this.word, required this.audioClickHandler});
  Word word;
  void Function() audioClickHandler;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        height: 400,
        child: Card(
          color: Theme.of(context).cardTheme.color,
          elevation: Theme.of(context).cardTheme.elevation,
          shadowColor: Theme.of(context).cardTheme.shadowColor,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                word.word.isNotEmpty
                    ? Text('Meaning',
                        style: Theme.of(context).textTheme.headlineSmall)
                    : Container(),
                Text(
                    word.meaning.isNotEmpty
                        ? ' ${word.meaning}'
                        : ErrorStrings.na,
                    style: Theme.of(context).textTheme.headlineSmall),
                word.audioName.isNotEmpty
                    ? GestureDetector(
                        onTap: audioClickHandler,
                        child: Icon(
                          Icons.volume_up,
                          color: Colors.blue,
                          size: 50,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
