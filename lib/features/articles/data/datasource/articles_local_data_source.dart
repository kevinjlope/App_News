import 'dart:developer';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/article_model.dart';

abstract class ArticlesLocalDataSource {
  /// Gets the cached [ArticleModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<ArticleModel>> getLatestArticles();

  /// Caches the given [ArticleModel].
  Future<void> cacheArticlesByCountry(
      List<ArticleModel> articleToCacheByCountry);
}

const String articles_cached = 'articles_cached';

class ArticlesLocalDataSourceImpl implements ArticlesLocalDataSource {
  final SharedPreferences? sharedPreferences;

  ArticlesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheArticlesByCountry(
      List<ArticleModel> articleToCacheByCountry) {
    // TODO: implement cacheArticleByCountry
    log('cacheArticlesByCountry: ${articleToCacheByCountry[0].toString()}');
    return sharedPreferences!.setString(
        articles_cached,
        json.encode(articleToCacheByCountry
            .map((ArticleModel e) => e.toJson())
            .toList()));
  }

  @override
  Future<List<ArticleModel>> getLatestArticles() {
    // TODO: implement getLatestArticles
    final String? jsonString = sharedPreferences!.getString('articles_cached');
    if (jsonString != null) {
      log('jsonString: $jsonString');
      return Future<List<ArticleModel>>.value(getListFromJson(jsonString));
    } else {
      throw CacheException();
    }
    // ArticleModel.fromListJson(jsonString));
  }

  List<ArticleModel> getListFromJson(String? string) {
    Map<String, dynamic> jsonDecode = json.decode(string!);
    List<dynamic> list = jsonDecode['articles'];
    List<ArticleModel> articles = list.map((dynamic item) {
      return ArticleModel.fromMap(item);
    }).toList();
    return articles;
  }
}
