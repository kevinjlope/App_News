import 'package:flutter/material.dart';
import 'package:news/src/models/news_models.dart';
import 'package:news/src/theme/tema.dart';

class ListNews extends StatelessWidget {
  List<Article> news ;
  
  ListNews({
    Key? key,
    required List<Article> this.news}) : 
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index){
        return _Noticia(noticia: this.news[index], index: index);
      });
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

   _Noticia({
    Key? key,
    required this.noticia,
    required this.index
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _CardTopBar(noticia: noticia,index: index,),
          _CardTitle(noticia: noticia),
          _CardImage(noticia: noticia),
          _CardBody(noticia: noticia),
          _CardButtons(),
          SizedBox(height: 10.0,),
          Divider(),
        ],
      )
    );
  }
}

class _CardButtons extends StatelessWidget {
  //const _CardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: myTheme.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Icon(Icons.star_outline),
          ),
          SizedBox(width: 10.0,),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article noticia;

  _CardBody({Key? key,
  required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(noticia.description ?? ''),
    );
  }
}
class _CardImage extends StatelessWidget {
  
  final Article noticia;

  const _CardImage({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        child: Container(
          child: (noticia.urlToImage != null) ?
          FadeInImage(
            placeholder: AssetImage('assets/img/giphy.gif'), 
            image: NetworkImage(noticia.urlToImage?? '')) : Image(image: AssetImage('assets/img/no-image.png'))
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article noticia;
  const _CardTitle({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(noticia.title,
      style: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold
      ),),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  
  final Article noticia;
  final int index;
  const _CardTopBar({
    Key? key, 
    required this.noticia, 
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text('${index + 1}',
          style: TextStyle(
            color: myTheme.accentColor
          ),),
          Text(
            '${noticia.source.name}',
            
          )
        ],
      ),
    );
  }
}
