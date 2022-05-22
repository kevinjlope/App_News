import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tab1_page.dart';
import 'tab2_page.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _NavigationModel navigationModel =
        Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
      currentIndex: navigationModel.pageCurrent,
      onTap: (int i) => navigationModel.pageCurrent = i,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'For you'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Headlines'),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _NavigationModel navigationModel =
        Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      //physics: NeverScrollableScrollPhysics(),
      children: const <Widget>[Tab1Page(), Tab2Page()],
    );
  }
}

// ignore: prefer_mixin
class _NavigationModel with ChangeNotifier {
  int _pageCurrent = 0;

  final PageController _pageController = PageController();

  int get pageCurrent => _pageCurrent;

  set pageCurrent(int value) {
    _pageCurrent = value;

    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250), curve: Curves.easeInCubic);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
