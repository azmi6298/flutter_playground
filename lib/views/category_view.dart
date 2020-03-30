import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'base_app_bar.dart';
import 'blog_tile.dart' as blogTile;

class CategoryView extends StatefulWidget {
  final String categoryName;
  CategoryView({this.categoryName});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  getArticles() async{
    CategoryNews newsClass = new CategoryNews();
    await newsClass.getNews(widget.categoryName);
    articles = newsClass.articles;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(),
      ),
      body: _loading ? 
        Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ):
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: 
                    Text(widget.categoryName.toUpperCase(), 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                ),
                /// Blogs
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index){
                      return blogTile.BlogTile(
                        imageUrl: articles[index].urlToImage, 
                        title: articles[index].title, 
                        desc: articles[index].description,
                        url: articles[index].url);
                    }
                  ),
                )
              ]
            )
          ),
        ),
    );
  }
}