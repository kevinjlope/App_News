import 'package:flutter/material.dart';
import 'package:news/src/models/news_models.dart';
import 'package:news/src/.env/env.dart';
import 'package:http/http.dart' as http;
class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService(){
    this.getTopHeadlines();
  }
  getTopHeadlines() async {
    final url = "$URL/top-headlines?apiKey=$API_KEY&country=us";
    final response = await http.get(Uri.parse(url));
    final newsResponse = NewsResponse.fromJson(response.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}