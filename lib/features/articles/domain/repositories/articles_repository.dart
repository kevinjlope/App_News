import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/article.dart';

abstract class ArticlesRepository {
  Future<Either<Failure, List<Article>>> getArticlesByCountry(String country);
}