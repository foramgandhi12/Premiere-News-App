import 'package:http/http.dart' as http;
import 'article.dart';
import 'dart:convert';

class News {
  List<Article> news = [];

  String api_key = '';
  String headline = 'top-headlines';

  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/${headline}?country=us&apiKey=${api_key}';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element['content'],
          );
          news.add(article);
        }
      });
    }
  }
}