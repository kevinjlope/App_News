import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'source.dart';

// ignore: must_be_immutable
class Article extends Equatable {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
  
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
