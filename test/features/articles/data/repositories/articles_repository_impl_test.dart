import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news/core/error/exception.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/platform/network_info.dart';
import 'package:news/features/articles/data/datasource/articles_local_data_source.dart';
import 'package:news/features/articles/data/datasource/articles_remote_data_source.dart';
import 'package:news/features/articles/data/models/article_model.dart';
import 'package:news/features/articles/data/repositories/articles_repository_impl.dart';
import 'package:news/features/articles/domain/entities/article.dart';
import 'package:news/features/articles/domain/entities/source.dart';

class MockSource extends Mock implements Source {}

class MockArticle extends Mock implements Article {}

class MockArticleModel extends Mock implements ArticleModel {}

class MockArticlesRemoteDataSource extends Mock
    implements ArticlesRemoteDataSource {}

class MockArticlesLocalDataSource extends Mock
    implements ArticlesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ArticlesRepositoryImpl? repository;
  MockArticlesRemoteDataSource? mockArticlesRemoteDataSource;
  MockArticlesLocalDataSource? mockArticlesLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;

  setUp(() {
    log('primer setup');
    mockArticlesRemoteDataSource = MockArticlesRemoteDataSource();
    mockArticlesLocalDataSource = MockArticlesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ArticlesRepositoryImpl(
      remoteDataSource: mockArticlesRemoteDataSource,
      localDataSource: mockArticlesLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getArticlesByCountry', () {
    const String country = 'us';
    final ArticleModel tArticleModel = MockArticleModel();
    final List<ArticleModel> tArticlesModel = <ArticleModel>[
      tArticleModel,
      tArticleModel
    ];
    final List<Article> tArticlesEntity = tArticlesModel;

    group('device is online', () {
      setUp(() {
        //arrange
        log('setup group');
        when(() => mockArticlesLocalDataSource!.cacheArticleByCountry(any()))
            .thenAnswer((_) async => Future<void>.value());
        when((() => mockNetworkInfo!.isConnected))
            .thenAnswer((_) async => true);
      });

      test(
          'Should return remote data when the call to remote data source'
          ' is successful', () async {
        //arrange
        when(() => mockArticlesRemoteDataSource!.getArticlesByCountry(country))
            .thenAnswer((_) async => tArticlesModel);
        //act
        final Either<Failure, List<Article>> result =
            await repository!.getArticlesByCountry(country);
        //assert
        verify(
            () => mockArticlesRemoteDataSource!.getArticlesByCountry(country));
        expect(result, equals(Right<Failure, List<Article>>(tArticlesEntity)));
      });

      test(
          'Should cache the data locally when the call to remote data source'
          ' is successful', () async {
        //arrange
        when(() => mockArticlesRemoteDataSource!.getArticlesByCountry(country))
            .thenAnswer((_) async => tArticlesModel);
        //act
        await repository!.getArticlesByCountry(country);
        //assert
        verify(
            () => mockArticlesRemoteDataSource!.getArticlesByCountry(country));
        verify(() =>
            mockArticlesLocalDataSource!.cacheArticleByCountry(tArticlesModel));
      });

      test(
          'Should return server failure when the call to remote data source'
          ' is unsuccessful', () async {
        //arrange
        when(() => mockArticlesRemoteDataSource!.getArticlesByCountry(country))
            .thenThrow(ServerException());
        //act
        final Either<Failure, List<Article>> result =
            await repository!.getArticlesByCountry(country);
        //assert
        verify(
            () => mockArticlesRemoteDataSource!.getArticlesByCountry(country));
        verifyZeroInteractions(mockArticlesLocalDataSource);
        expect(result, equals(Left<Failure, List<Article>>(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        //arrange
        log('setup group');
        when(() => mockArticlesLocalDataSource!.cacheArticleByCountry(any()))
            .thenAnswer((_) async => Future<void>.value());

        when(() => mockArticlesRemoteDataSource!.getArticlesByCountry(any()))
            .thenAnswer(
                (_) async => Future<List<ArticleModel>>.value(tArticlesModel));
        when((() => mockNetworkInfo!.isConnected))
            .thenAnswer((_) async => false);
      });

      test(
          'Should return last locally cached data when the cached data is '
          'present', () async {
        //arrange
        when(() => mockArticlesLocalDataSource!.getLatestArticles())
            .thenAnswer((_) async => tArticlesModel);
        //act
        final Either<Failure, List<Article>> result =
            await repository!.getArticlesByCountry(country);
        //assert
        verifyZeroInteractions(mockArticlesRemoteDataSource);
        verify(() => mockArticlesLocalDataSource!.getLatestArticles());
        expect(result, equals(Right<Failure, List<Article>>(tArticlesEntity)));
      });

      test('Should return CacheFailure when there is no cached data present',
          () async {
        //arrange
        when(() => mockArticlesLocalDataSource!.getLatestArticles())
            .thenThrow(CacheException());
        //act
        final Either<Failure, List<Article>> result =
            await repository!.getArticlesByCountry(country);
        //assert
        verifyZeroInteractions(mockArticlesRemoteDataSource);
        verify(() => mockArticlesLocalDataSource!.getLatestArticles());
        expect(result, equals(Left<Failure, List<Article>>(CacheFailure())));
      });
    });
  });
}
