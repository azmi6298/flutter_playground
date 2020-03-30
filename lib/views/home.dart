import 'package:cached_network_image/cached_network_image.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/views/base_app_bar.dart';
import 'package:newsapp/views/category_view.dart';
import 'package:newsapp/views/blog_tile.dart' as blogTile;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  List countries = new List();

  bool _loading = true;
  String countryCode = 'id';

  @override
  void initState() { 
    super.initState();
    categories = getCategories();
    countries = getCountries();
    getArticles();
  }

  getArticles() async{
    News newsClass = new News();
    await newsClass.getNews(countryCode);
    articles = newsClass.articles;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), 
      widgets: <Widget>[
        GestureDetector(
          onTap: (){},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Flags.getMiniFlag('id', null, null),
          ),
        )
      ],),
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
                /// Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 ),
                  height: 70,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(
                        categoryName: categories[index].categoryName,
                        imageUrl: categories[index].imageUrl,
                      );
                    },
                  )
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

class CategoryTile extends StatelessWidget {
  final String categoryName, imageUrl;
  CategoryTile({this.categoryName, this.imageUrl});

  @override
  Widget build(BuildContext context) { 
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryView(
            categoryName: categoryName.toLowerCase()
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: CachedNetworkImage(imageUrl: imageUrl, width: 120, height: 60, fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(7)
              ),
              child: Text(categoryName, style: TextStyle(color: Colors.white)),
            )
          ]
        ),
      ),
    );
  }
}