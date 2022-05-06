import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/category_views.dart';

import 'package:news_app/views/artical_view.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<Home>{

  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;

  @override
  void initState(){
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('News'),
            Text('App', style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        centerTitle: true,
        elevation: 0.3,
      ),
      body:_loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ) ,
      ): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              //category
              Container(

                height: 70,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(
                        imageURL: categories[index].imageURL,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),
              //blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return BlogTile(
                        imageURL: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );
                    }),
              )
            ],
          ),
        ),
      )
    );
  }

}

class CategoryTile extends StatelessWidget{
  final String imageURL, categoryName;
  CategoryTile({required this.imageURL, required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>  CatagoryNews(
              category: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl: imageURL, width: 120, height: 60, fit: BoxFit.cover, ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),

              child: Text(categoryName, style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    );
  }

}
class BlogTile extends StatelessWidget{
  final String imageURL, title, desc, url;
  BlogTile({required this.imageURL, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticaleView(
              blogurl: url,

            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageURL),
            ),
            Text(title, style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),),
            SizedBox(height: 8,),
            Text(desc, style: TextStyle(
              color: Colors.black54,
            ),)
          ],
        ),
      ),
    );
  }
  
}