import 'package:flutter/material.dart';
import 'package:news/src/services/news_service.dart';
import 'package:news/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsService>(context);
      //body: ListNews(news: newsModel.headlines)
    return Scaffold(
      body: (newsModel.headlines.length == 0)
        ? CircularProgressIndicator()
        : ListNews(news: newsModel.headlines)
    );
  }

  @override
  bool get wantKeepAlive => true;
}
