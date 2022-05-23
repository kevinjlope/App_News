import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:news/features/articles/data/models/source_model.dart';
import 'package:news/features/articles/domain/entities/source.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final SourceModel tSource = SourceModel(
    id: 'source id',
    name: 'source name',
  );

  test('should be a subclass of Source entity', () async {
    expect(tSource, isA<Source>());
  });

  group('fromMap', () {
    test('should return a valid source model', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('source.json'));
      //act
      final SourceModel result = SourceModel.fromMap(jsonMap);

      //assert
      expect(result, tSource);
    });
  });

  group('toMap', () {
    test('should return a JSON map containing the proper data', () async {
      //arrange

      const Map<String, dynamic> expected = <String, dynamic>{
        'id': 'source id',
        'name': 'source name',
      };

      //act
      final Map<String, dynamic> result = tSource.toMap();

      //assert
      expect(result, expected);
    });
  });
}
