import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/articles_repository.dart';

class GetArticlesByCountry {
  final ArticlesRepository? articlesRepository;

  GetArticlesByCountry(this.articlesRepository);

  Future<Either<Failure, List<Article>>> call(
      {required String country}) async {
    return await articlesRepository!.getArticlesByCountry(country);
  }
  
}