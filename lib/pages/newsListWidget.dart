import 'package:flutter/material.dart';
import '../shared/newsList.dart';

Widget listWidget(NewsList item) {
  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 2.0),
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Hero(
            tag: '${item.newsTitle}',
            child: Container(
              width: 103.0,
              height: 110.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(item.imgUrl),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.newsTitle,
                style: TextStyle(fontSize: 18.00),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(children: [
                CircleAvatar(
                  backgroundColor: Color(0xffE6E6E6),
                  radius: 13,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage("https://media-exp1.licdn.com/dms/image/C5603AQFj1aS63EknAA/profile-displayphoto-shrink_100_100/0/1552509106281?e=1623283200&v=beta&t=2iHLO2Jp28rfUsoJRuBpZI9GdZRXiqIljXf7TWD2eyQ"),
                  )
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  item.author,
                  style: TextStyle(fontSize: 12.0),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Icon(Icons.date_range),
                Text(
                  item.date,
                  style: TextStyle(fontSize: 12.0),
                )
              ])
            ],
          ))
        ],
      ),
    ),
  );
}
