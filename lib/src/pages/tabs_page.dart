import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navegation(),
      ),
    );
  }
}

class _Navegation extends StatelessWidget {
  const _Navegation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavegationModel>(context);
    return BottomNavigationBar(
      currentIndex: navegationModel.pageCurrent,
      onTap: (i) => navegationModel.pageCurrent = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text('For you')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text('Header'))
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
    final navegationModel = Provider.of<_NavegationModel>(context);

    return PageView(
      controller: navegationModel.pageController,
      //physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        )
      ],
    );
  }
}

class _NavegationModel with ChangeNotifier {
  int _pageCurrent = 0;

  PageController _pageController = new PageController();

  int get pageCurrent => this._pageCurrent;

  set pageCurrent(int value) {
    this._pageCurrent = value;

    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeInCubic);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
