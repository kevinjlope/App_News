import 'package:flutter/material.dart';

import '../models/news_models.dart';

// ignore: must_be_immutable
class ListNews extends StatelessWidget {
  List<Article> news;

  ListNews({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index) {
          return _Notice(notice: news[index], index: index);
        });
  }
}

class _Notice extends StatelessWidget {
  final Article notice;
  final int index;

  const _Notice({Key? key, required this.notice, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CardTopBar(
          notice: notice,
          index: index,
        ),
        _CardTitle(notice: notice),
        _CardImage(notice: notice),
        _CardBody(notice: notice),
        _CardButtons(),
        const SizedBox(
          height: 10.0,
        ),
        const Divider(),
      ],
    );
  }
}

class _CardButtons extends StatelessWidget {
  //const _CardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {},
          fillColor: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: const Icon(Icons.star_outline),
        ),
        const SizedBox(
          width: 10.0,
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: const Icon(Icons.more),
        )
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article notice;

  const _CardBody({Key? key, required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(notice.description ?? ''),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article notice;

  const _CardImage({Key? key, required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        child: Container(
            child: (notice.urlToImage != null)
                ? FadeInImage(
                    placeholder: const AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(notice.urlToImage ?? ''))
                : const Image(image: AssetImage('assets/img/no-image.png'))),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article notice;
  const _CardTitle({Key? key, required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        notice.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article notice;
  final int index;
  const _CardTopBar({
    Key? key,
    required this.notice,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.red),
          ),
          Text(
            notice.source.name,
          )
        ],
      ),
    );
  }
}
