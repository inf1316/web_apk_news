import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:web_apk_news/service/newsApiService.dart';
import 'package:web_apk_news/shared/newsList.dart';
import 'newsDetailsWidget.dart';
import 'newsListWidget.dart';

class News extends StatefulWidget {
  bool present;
  News({Key key, this.present}) : super(key: key);

  @override
  _NewsState createState() => _NewsState(this.present);
}

class _NewsState extends State<News> {
  bool present;
  _NewsState(this.present);
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
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: FutureBuilder(
            future:
                present ? apiService.getAll(true) : apiService.getAll(false),
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
                              PageTransition(
                                type: PageTransitionType.scale,
                                alignment: Alignment.bottomCenter,
                                child: NewsDetailsScreen(
                                    item: news[index],
                                    tag: news[index].newsTitle),
                              ));
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
      ),
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      new News();
    });
    return null;
  }
}
