import 'package:cached_network_image/cached_network_image.dart';
import 'package:flag/flag.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/models/country_model.dart';
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
  List<CountryModel> countries = new List<CountryModel>();

  bool _loading = true;
  String countryCode = 'id';
  String countryName;

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

  void showFlushBar(BuildContext context){
    Flushbar(
      title: 'News source changed to',
      message: countryName,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      borderRadius: 8,
      backgroundGradient: LinearGradient(colors: [Colors.blue.shade600, Colors.blue.shade300], stops: [0.6, 1]),
      boxShadows: [BoxShadow(color: Colors.black45, offset: Offset(3,3), blurRadius: 3)],
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void _onFlagPressed(){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: Color(0xFF737373),
        // height: 150*countries.length.toDouble(),
        height: MediaQuery.of(context).size.height/4,
        child: Container(
          child: _countryMenu(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft : const Radius.circular(10),
              topRight : const Radius.circular(10),
            )
          ),
        ),
      );
    });
  }

  ListView _countryMenu(){
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index){
        return ListTile(
          leading: Flags.getMiniFlag(countries[index].countryCode, null, null),
          title: Text(countries[index].countryName),
          onTap: () => _selectCountry(countries[index].countryCode.toLowerCase(), countries[index].countryName),
        );
      }
    );
  }

  void _selectCountry(countryCode, countryName){
    Navigator.pop(context);
    setState(() {
      this.countryCode = countryCode;
      this.countryName = countryName;
      getArticles();
      showFlushBar(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), 
      widgets: <Widget>[
        GestureDetector(
          onTap: () => _onFlagPressed(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Flags.getMiniFlag(countryCode.toUpperCase(), null, null),
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
                        countryCode: this.countryCode,
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
  final String categoryName, imageUrl, countryCode;
  CategoryTile({this.categoryName, this.imageUrl, this.countryCode});

  @override
  Widget build(BuildContext context) { 
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryView(
            categoryName: categoryName.toLowerCase(),
            countryCode: this.countryCode,
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 120, 
                height: 60, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                )
            ),),
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