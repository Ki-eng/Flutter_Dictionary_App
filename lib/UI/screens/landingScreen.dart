import 'package:dictionary_app/UI/screens/audio_player_screen.dart';
import 'package:dictionary_app/UI/widgets/meaning_card_widget.dart';
import 'package:dictionary_app/UI/widgets/custom_button_widget.dart';
import 'package:dictionary_app/constants/appStrings.dart';
import 'package:dictionary_app/UI/widgets/custom_textField_widget.dart';
import 'package:dictionary_app/data/word.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_app/service/dictionary_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DictionayScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<DictionayScreen> createState() => _DictionayScreenState();
}

class _DictionayScreenState extends State<DictionayScreen> {
  String searchString = '';

  DictionaryService _dictionaryService = DictionaryService();

  Word? wordMeaning;
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
  }

  void showLoader() {
    EasyLoading.show(status: Appstrings.loading);
  }

  void dismissLoader() {
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    /* final response =
        _dictionaryService.getInitialData().then((data) => print(data.meaning));

   print(response);*/
    _dictionaryService.getInitialData().then((data) {
      setState(() {
        toggleIsLoading();
        searchString = data.word;
        wordMeaning = data;
      });
    });
    toggleIsLoading();
    super.initState();
  }

  void updateUI(String value) {
    setState(() {
      searchString = value;
    });
  }

  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });

    if (isLoading) {
      showLoader();
    } else {
      dismissLoader();
    }
  }

  void changeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void onPress() async {
    changeFocus();
    toggleIsLoading();
    final response = await _dictionaryService.getData(searchString);
    controller.clear();

    setState(() {
      wordMeaning = response;
    });
    toggleIsLoading();
  }

  void handleAudio() {
    Navigator.pushNamed(
      context,
      AudioPlayerScreen.routeName,
      arguments: _dictionaryService.getAudioUrl(wordMeaning?.audioName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Appstrings.appBarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextfieldWidget(
            controller: controller,
            onChange: updateUI,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: CustomButtonWidget(
                  onPressed: onPress,
                  title: Icon(
                    Icons.near_me,
                    size: 32,
                    color: Colors.amber.shade700,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              '${isLoading ? Appstrings.searchingWord : Appstrings.word} $searchString',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          wordMeaning != null
              ? Meaningcard(
                  word: wordMeaning!,
                  audioClickHandler: handleAudio,
                )
              : Container(),
        ],
      ),
    );
  }
}
