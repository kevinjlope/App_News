import '../models/article_model.dart';

abstract class ArticlesRemoteDataSource {
  /// Gets the list of articles from the remote data source.
  /// 
  /// Throws [ServerException] if the server is unavailable.
  Future<List<ArticleModel>> getArticlesByCountry(String country);
}

