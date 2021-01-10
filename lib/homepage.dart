import 'package:flutter/material.dart';
import 'news.dart';
import 'package:intl/intl.dart';
import 'player_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loadingInProgress;
  var newslist;

  void getNews() async {
    News news = News();
    await news.getNews();
    setState(() {
      newslist = news.news;
      loadingInProgress = false;
    });
  }

  @override
  void initState() {
    loadingInProgress = true;
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: loadingInProgress
              ? Center(
                  child: Text('Loading...'),
                )
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Top Headlines',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(newslist[index].title),
                            subtitle: Text(DateFormat.Hm().format(newslist[index].publishedAt),),
                            leading: Image.network(newslist[index].urlToImage),
                            trailing: PlayerWidget(body: newslist[index].content,),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
