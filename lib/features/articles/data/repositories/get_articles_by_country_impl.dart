import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/articles_repository.dart';

class GetArticlesByCountryImpl implements ArticlesRepository {

  @override
  Future<Either<Failure, List<Article>>> getArticlesByCountry(String country) {
    // TODO: implement getArticlesByCountry
    throw UnimplementedError();
  }

}