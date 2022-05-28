import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/articles_repository.dart';
import '../datasource/articles_local_data_source.dart';
import '../datasource/articles_remote_data_source.dart';
import '../models/article_model.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final ArticlesRemoteDataSource? remoteDataSource;
  final ArticlesLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  ArticlesRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Article>>> getArticlesByCountry(
      String country) async {
    // TODO: implement getArticlesByCountry
    if (await networkInfo!.isConnected) {
      try {
        List<ArticleModel> remoteArticlesByCountry =
            await remoteDataSource!.getArticlesByCountry(country);
        localDataSource!.cacheArticleByCountry(remoteArticlesByCountry);
        log('go to for try');
        return Right<Failure, List<Article>>(remoteArticlesByCountry);
      } on ServerException {
        log('go to exception');
        return Left<Failure, List<Article>>(ServerFailure());
      }
    } else {
      log('go to else');
      try {
        final List<ArticleModel> localArticlesByCountry =
            await localDataSource!.getLatestArticles();
        return Right<Failure, List<Article>>(localArticlesByCountry);
      } on CacheException {
        return Left<Failure, List<Article>>(CacheFailure());
      }
    }
  }
}
