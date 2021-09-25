import 'package:flutter/material.dart';
import 'package:news/src/pages/tabs_page.dart';
import 'package:news/src/theme/tema.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: TabsPage()
    );
  }
}