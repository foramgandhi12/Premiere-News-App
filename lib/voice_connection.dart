import 'package:http/http.dart' as http;
import 'dart:convert';

var _apikey = 'AIzaSyAhvG0ycPWz3K6F9-NR901CTV8FpfsA6GY';

Future<http.Response> voiceResponse (String text) async {
  String url = 'https://texttospeech.googleapis.com/v1beta1/text:synthesize?key=$_apikey';

  var body = jsonEncode(
      {
        "audioConfig": {
          "audioEncoding": "LINEAR16",
          "pitch": 0,
          "speakingRate": 1
        },
        "input": {
          "text": text
        },
        "voice": {
          "languageCode": "en-US",
          "name": "en-US-Wavenet-D"
        }
      }
  );

  var response = http.post(url,
    headers: {"Content-type": "application/json"},
    body: body
  );

  return response;
}