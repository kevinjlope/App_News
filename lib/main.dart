import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'src/pages/tabs_page.dart';
import 'src/services/news_service.dart';
import 'theme/theme.dart';

void main() => runApp(const MyApp());

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
          title: 'Material App',
          theme: myTheme,
          debugShowCheckedModeBanner: false,
          home: const TabsPage()),
    );
  }
}
