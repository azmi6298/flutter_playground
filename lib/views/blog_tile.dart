import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'article_view.dart';

class BlogTile extends StatefulWidget {
  final imageUrl, title, desc, url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});
  
  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl: widget.url,
          )
        ));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: CachedNetworkImage(imageUrl: widget.imageUrl)),
                  SizedBox(height:10),
                  Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  Text(widget.desc, style: TextStyle(color: Colors.black45),)
                ],),
            ),
          ]
        ),
      ),
    );
  }
}