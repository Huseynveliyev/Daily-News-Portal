import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  static Future<List<Articles>?> getNews() async {
    var author;
    String url =
        'https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=5750df9119a1460baccd624d6ae5b67f';

    final response = await http.get(Uri.parse(url));

    if (response.body.isNotEmpty) {
      final responseJson = jsonDecode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    }
    return author;
  }
}
