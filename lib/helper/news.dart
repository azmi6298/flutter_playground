import 'dart:convert';
import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> articles = new List<ArticleModel>();

  Future<void> getNews(String countryCode) async {
    String url = 'http://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=148c7b8aaee747f9a92cad7151981e70';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((data){
          if(data['urlToImage'] != null && data['description'] != null){
            ArticleModel newArticle = new ArticleModel(
              author: data['author'],
              title: data['title'],
              description: data['description'],
              url: data['url'],
              urlToImage: data['urlToImage'],
              content: data['content']
            );
            articles.add(newArticle);
          }
        }
      );
    }
  }
}

class CategoryNews {
  List<ArticleModel> articles = new List<ArticleModel>();

  Future<void> getNews(String category) async {
    String url = 'http://newsapi.org/v2/top-headlines?category=$category&country=id&apiKey=148c7b8aaee747f9a92cad7151981e70';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((data){
          if(data['urlToImage'] != null && data['description'] != null){
            ArticleModel newArticle = new ArticleModel(
              author: data['author'],
              title: data['title'],
              description: data['description'],
              url: data['url'],
              urlToImage: data['urlToImage'],
              content: data['content']
            );
            articles.add(newArticle);
          }
        }
      );
    }
  }
}