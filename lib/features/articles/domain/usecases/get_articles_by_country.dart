import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repositories/articles_repository.dart';

class GetArticlesByCountry extends UseCase<List<Article>, Params> {
  final ArticlesRepository? articlesRepository;

  GetArticlesByCountry(this.articlesRepository);

  @override
  Future<Either<Failure, List<Article>>> call(Params params) async {
    log('times');
    return await articlesRepository!.getArticlesByCountry(params.country);
  }
}

class Params extends Equatable {
  final String country;

  const Params({required this.country});

  @override
  List<Object?> get props => <Object?>[country];
}
