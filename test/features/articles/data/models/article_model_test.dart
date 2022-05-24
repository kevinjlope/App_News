import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:news/features/articles/data/models/article_model.dart';
import 'package:news/features/articles/data/models/source_model.dart';
import 'package:news/features/articles/domain/entities/article.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final ArticleModel tArticle = ArticleModel(
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

  test('should be a subclass of Article', () {
    expect(tArticle, isA<Article>());
  });

  group('fromMap', () {
    test('should return a valid article model', () {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('article.json'));
      //act
      final ArticleModel result = ArticleModel.fromMap(jsonMap);

      //assert
      expect(result, tArticle);
    });
  });

  group('toMap', () {
    test('should return a JSON map containing the proper data', () {
      //arrange

      const Map<String, dynamic> expected = <String, dynamic>{
        'source': <String, dynamic>{
          'id': 'source id',
          'name': 'source name',
        },
        'author': 'article author',
        'title': 'article title',
        'description': 'article description',
        'url': 'article url',
        'urlToImage': 'article url to image',
        'publishedAt': '2020-10-10T00:00:00.000Z',
        'content': 'article content',
      };

      //act
      final Map<String, dynamic> result = tArticle.toMap();

      //assert
      expect(result, expected);
    });
  });
}
