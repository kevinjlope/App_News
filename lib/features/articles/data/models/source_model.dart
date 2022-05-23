import 'dart:convert';

import '../../domain/entities/source.dart';

class SourceModel extends Source {
  SourceModel({String? id, required String name})
      : super(id: id ?? '', name: name);

  factory SourceModel.fromJson(String str) =>
      SourceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SourceModel.fromMap(Map<String, dynamic> json) => SourceModel(
        id: json['id'],
        name: json['name'],
      );

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}
