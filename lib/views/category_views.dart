import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';

import 'package:news_app/views/artical_view.dart';

class CatagoryNews extends StatefulWidget{
  final String category;
  CatagoryNews({required this.category});

  @override
  CatagoryNewsState createState() => CatagoryNewsState();
}
class CatagoryNewsState extends State<CatagoryNews>{
  bool _loading = true;
  List<ArticleModel> articles = <ArticleModel>[];

  void initState(){
    super.initState();
    getCategoryNews();
  }
  getCategoryNews() async{
    Categorynews newsClass = Categorynews();
    await newsClass.getNews(widget.category);
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
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
              Icon(Icons.save),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0.3,
      ),
      body: _loading ? Center(
      child: Container(
    child: CircularProgressIndicator(),
    ) ,
    ): SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
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