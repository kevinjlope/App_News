import 'package:flutter/material.dart';

class L10n {
  static final List<Locale> languages = <Locale>[const Locale('en')];

  // static final Map<int, LanguageCode> mapLanguages = <int, LanguageCode>{
  //   0: LanguageCode('english', 'en'),
  // };

}

class LanguageCode<T1, T2> {
  final T1 language;
  final T2 isoCode;

  LanguageCode(this.language, this.isoCode);

}
