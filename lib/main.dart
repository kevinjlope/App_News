import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/l10n.dart';
import 'l10n/locale_keys.g.dart';
import 'src/pages/tabs_page.dart';
import 'src/services/news_service.dart';
import 'src/theme/theme.dart';

// void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: L10n.languages,
    path: 'assets/l10n',
    fallbackLocale: L10n.languages[0],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        // ignore: always_specify_types
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: LocaleKeys.title,
          theme: myTheme,
          debugShowCheckedModeBanner: false,
          home: const TabsPage()),
    );
  }
}
