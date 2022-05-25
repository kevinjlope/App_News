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
    final ArticleModel tArticleModel = ArticleModel(
      source: SourceModel(
        id: 'source id',
        name: 'source name',
      ),
      author: 'article author',
      title: 'article title',
      description: 'article description',
      url: 'article url',
      urlToImage: 'article url to image',
      publishedAt: DateTime.utc(2020, 10, 10),
      content: 'article content',
    );
    final Article tArticleEntity = tArticleModel;
    final List<ArticleModel> tArticlesModel = <ArticleModel>[
      tArticleModel,
      tArticleModel
    ];
    final List<Article> tArticlesEntity = <Article>[
      tArticleEntity,
      tArticleEntity
    ];

    void runTestOnline(Function body) {
      group('device is online', () {
        setUp(() {
          when((() => mockNetworkInfo!.isConnected))
              .thenAnswer((_) async => true);
        });
        // ignore: avoid_dynamic_calls
        body();
      });
    }

    void runTestOffline(Function body) {
      group('device is offline', () {
        setUp(() {
          when((() => mockNetworkInfo!.isConnected))
              .thenAnswer((_) async => false);
        });
        // ignore: avoid_dynamic_calls
        body();
      });
    }

    // test('Should check if the device is online', () {
    //   //arrange
    //   when((() => mockNetworkInfo!.isConnected)).thenAnswer((_) async => true);
    //   //act
    //   repository!.getArticlesByCountry(country);
    //   //assert
    //   verify(() => mockNetworkInfo!.isConnected);
    // });

    group('device is online', () {
      setUp(() {
        when((() => mockNetworkInfo!.isConnected))
            .thenAnswer((_) async => true);
      });

      test(
          'Should return remote data when the call to remote data source is successful',
          () async {
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
            result, equals(Right<Failure, List<Article>>(tArticlesModel)));
      });
    });
  });
}
