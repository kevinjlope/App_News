import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news/core/error/exception.dart';
import 'package:news/features/articles/data/datasource/articles_local_data_source.dart';
import 'package:news/features/articles/data/models/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockArticleModel extends Mock implements ArticleModel {}

void main() {
  ArticlesLocalDataSourceImpl? localDataSource;
  MockSharedPreferences? mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        ArticlesLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLatestArticles', () {
    final ArticleModel tArticleModel =
        ArticleModel.fromJson(fixture('article.json'));

    final List<ArticleModel> tArticlesModel = <ArticleModel>[
      tArticleModel,
      tArticleModel
    ];

    test(
        'should return List<ArticleModel> from SharedPreferences when'
        ' there are anyone in the cache', () async {
      //arrange
      when(() => mockSharedPreferences!.getString(any()))
          .thenReturn(fixture('articles_cached.json'));
      //act
      final List<ArticleModel> result =
          await localDataSource!.getLatestArticles();
      //assert
      verify(() => mockSharedPreferences!.getString('articles_cached'));
      expect(result, equals(tArticlesModel));
    });

    test('should throw a CacheException when there is not a cached value', () {
      //arrange
      when(() => mockSharedPreferences!.getString(any())).thenReturn(null);
      //act
      final Future<List<ArticleModel>> Function() call =
          localDataSource!.getLatestArticles;
      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheArticlesByCountry', () {
    final ArticleModel tArticleModel = MockArticleModel();
    final List<ArticleModel> tArticlesModel = <ArticleModel>[
      tArticleModel,
      tArticleModel
    ];

    // test('should call SharedPreferences to cache the data', () {
    //   //act
    //   localDataSource!.cacheArticlesByCountry(tArticlesModel);
    //   //assert
    //   final String expectedJsonString = json.encode(tArticlesModel);
    //   verify(() => mockSharedPreferences!
    //       .setString(articles_cached, expectedJsonString));
    // });
  });
}
