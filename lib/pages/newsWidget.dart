import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/service/newsApiService.dart';
import 'package:web_apk_news/shared/newsList.dart';
import 'newsDetailsWidget.dart';
import 'newsListWidget.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final NewsApiService apiService = NewsApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: 100,
        child: FutureBuilder(
          future: apiService.getAll(),
          builder: (context, AsyncSnapshot<List<NewsList>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Column(children: [Icon(Icons.error, size: 120)]));
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<NewsList> news = snapshot.data;
              return ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsDetailsScreen(
                                    item: news[index],
                                    tag: news[index].newsTitle)));
                      },
                      child: listWidget(news[index]),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
