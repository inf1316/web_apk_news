import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/shared/jobOffer.dart';

class JobOffers extends StatelessWidget {
  final JobOffer jobOffer;

  JobOffers({Key key, @required this.jobOffer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(
            leading: Icon(
              Icons.visibility,
              color: Colors.black,
              size: 30,
            ),
            title: Text(
              jobOffer.title,
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text(
              jobOffer.subTitle,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 70.0,
              ),
              Icon(Icons.phone),
              Text(
                jobOffer.phone,
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
