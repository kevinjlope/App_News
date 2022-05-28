import '../models/article_model.dart';

abstract class ArticlesLocalDataSource {
  /// Gets the cached [ArticleModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<ArticleModel>> getLatestArticles();

  /// Caches the given [ArticleModel].
  Future<void> cacheArticleByCountry(
      List<ArticleModel> articleToCacheByCountry);
}
