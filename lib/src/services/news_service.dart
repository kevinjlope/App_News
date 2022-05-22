import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../.env/env_example.dart';
import '../models/news_models.dart';

// ignore: prefer_mixin
class NewsService with ChangeNotifier {
  List<Article> headlines = <Article>[];

  NewsService() {
    getTopHeadlines();
  }
  Future<void> getTopHeadlines() async {
    final String url = '$URL/top-headlines?apiKey=$API_KEY&country=us';
    final http.Response response = await http.get(Uri.parse(url));
    final NewsResponse newsResponse = NewsResponse.fromJson(response.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
