import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/custom/tweetWebView.dart';
import 'package:web_apk_news/service/newsApiService.dart';
import 'package:web_apk_news/shared/newsList.dart';
import 'package:string_validator/string_validator.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String tag;
  final NewsList item;

  NewsDetailsScreen({Key key, @required this.item, @required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // call to increase the views of the news
    final NewsApiService apiService = NewsApiService();
    apiService.setViews(item.view, item.idNews);

    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: '${item.newsTitle}',
                    child: Image.network(item.imgUrl, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(item.newsTitle,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Color(0xffE6E6E6),
                                radius: 13,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundImage:
                                      NetworkImage(item.imageAuthor),
                                )),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              item.author,
                              style: TextStyle(fontSize: 12.0),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.date_range, size: 20),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              item.date,
                              style: TextStyle(fontSize: 12.0),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.visibility),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              item.view.toString(),
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        listWidget(item.content)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listWidget(String content) {
    var portions = content.split('%');
    var endContent = [];

    var paragraph = "";
    List<Widget> widget = [];

    // format string
    for (var element in portions) {
      if (element.contains('https://')) {
        endContent.add(paragraph);
        endContent.add(element.trim());
        paragraph = "";
      } else {
        paragraph += element + " ";
      }
    }
    endContent.add(paragraph);

    for (var element in endContent) {
      if (element.contains('https://')) {
        widget.add(TweetWebView.tweetUrl(element));
      } else {
        widget.add(
          Text(element, style: TextStyle(fontSize: 15.0, height: 1.5)),
        );
      }
    }
    return Column(
      children: widget
    );
  }
}
