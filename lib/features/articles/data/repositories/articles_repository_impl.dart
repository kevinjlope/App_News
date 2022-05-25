import 'package:dartz/dartz.dart';

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
    networkInfo!.isConnected;
    return Right<Failure, List<Article>>(
        await remoteDataSource!.getArticlesByCountry(country));
  }
}
