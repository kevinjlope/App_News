import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/platform/network_info.dart';
import 'package:news/features/articles/data/datasource/articles_local_data_source.dart';
import 'package:news/features/articles/data/datasource/articles_remote_data_source.dart';
import 'package:news/features/articles/data/models/article_model.dart';
import 'package:news/features/articles/data/models/source_model.dart';
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
        expect(
            result, equals(Right<Failure, List<Article>>(tArticlesEntity)));
      });
    });
  });
}
