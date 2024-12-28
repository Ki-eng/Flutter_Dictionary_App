import 'dart:convert';

import 'package:dictionary_app/constants/appConstants.dart';
import 'package:dictionary_app/constants/error_strings.dart';
import 'package:dictionary_app/data/word.dart';
import 'package:http/http.dart' as http;

class DictionaryService {
  Future<Word> getData(String word) async {
    final Uri url =
        Uri.parse('${Appconstants.baseUrl}/$word?key=${Appconstants.apiKey}');

    print('Fetching data in progress');

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Error fetching data from server');
    }

    try {
      final dynamic decodedData = jsonDecode(response.body);

      // Validate data structure
      if (decodedData is! List) {
        throw Exception('Invalid API response: Expected a list');
      }

      final parsedData = decodedData.isNotEmpty ? decodedData[0] : {};

      // Validate parsedData structure (if needed)
      if (parsedData is! Map<String, dynamic>) {
        throw Exception('Invalid data format in API response');
      }

      final meaning = parsedData['shortdef']?.isNotEmpty == true
          ? parsedData['shortdef'][0]
          : '';

      final audioFile = parsedData['hwi']?['prs']?.isNotEmpty == true
          ? parsedData['hwi']['prs'][0]['sound']['audio']
          : '';

      print(meaning);
      print('Fetching data completed');

      return Word(
        word: word,
        meaning: meaning,
        audioName: audioFile,
      );
    } catch (e) {
      throw Exception('Error parsing data: ${e.toString()}');
    }
  }

  String getAudioUrl(String audioFileName) {
    if (audioFileName.isEmpty) {
      throw Exception(ErrorStrings.invalidAudioFile);
    }

    String folderName;
    final startWithAlphabetsOnly = RegExp(r'^[A-Za-z]');

    if (audioFileName.startsWith('gg')) {
      folderName = 'gg';
    } else if (audioFileName.startsWith('bix')) {
      folderName = 'bix';
    } else if (!startWithAlphabetsOnly.hasMatch(audioFileName)) {
      folderName = '_';
    } else {
      folderName = audioFileName[0];
    }

    return '${Appconstants.audioBaseUrl}$folderName/$audioFileName${Appconstants.audioFileExtension}';
  }

  Future<Word> getInitialData() async {
    String? randomWord = await getRandomWord();

    if (randomWord == null) {
      throw Exception('rror fetching random word from server');
    }
    return await getData(randomWord);
  }

  Future<String?> getRandomWord() async {
    print('Fetching random word is in progress');

    http.Response randomWordResponse =
        await http.get(Uri.parse(Appconstants.randomWordApi));
    print('Random word fetching is completed');

    if (randomWordResponse.statusCode != 200 || randomWordResponse == null) {
      throw Exception('Error fetching random word from server');
    }

    final decodedData = jsonDecode(randomWordResponse.body);
    if (decodedData == null || decodedData.isEmpty) {
      return null; // Handle empty response case
    }
    return decodedData[0];
  }
}
