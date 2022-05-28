
import 'dart:convert';

import '../../domain/entities/article.dart';
import 'source_model.dart';

// ignore: must_be_immutable
class ArticleModel extends Article {
  ArticleModel(
      {required SourceModel source,
      String? author,
      required String title,
      String? description,
      required String url,
      String? urlToImage,
      required DateTime publishedAt,
      String? content})
      : super(
            source: source,
            author: author ?? '',
            title: title,
            description: description ?? '',
            url: url,
            urlToImage: urlToImage ?? '',
            publishedAt: publishedAt,
            content: content);

  factory ArticleModel.fromJson(String str) =>
      ArticleModel.fromMap(json.decode(str));
  
  String toJson() => json.encode(toMap());

  factory ArticleModel.fromMap(Map<String, dynamic> json) => ArticleModel(
        source: SourceModel.fromMap(json['source']),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: DateTime.parse(json['publishedAt']),
        content: json['content'],
      );
  
  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'source': source.toMap(),
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt.toIso8601String(),
        'content': content,
      };
}
