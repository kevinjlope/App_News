import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';
import '../widgets/list_news.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final NewsService newsModel = Provider.of<NewsService>(context);
    //body: ListNews(news: newsModel.headlines)
    return Scaffold(
        body: (newsModel.headlines.isEmpty)
            ? const CircularProgressIndicator()
            : ListNews(news: newsModel.headlines));
  }

  @override
  bool get wantKeepAlive => true;
}
