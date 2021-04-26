import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/service/jobOffersApiService.dart';
import 'package:web_apk_news/shared/jobOffer.dart';

class JobOffers extends StatefulWidget {
  const JobOffers({Key key}) : super(key: key);

  @override
  _JobOffersState createState() => _JobOffersState();
}

class _JobOffersState extends State<JobOffers> {
  final JobOffersApiService apiService = JobOffersApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: apiService.getAll(),
          builder: (context, AsyncSnapshot<List<JobOffer>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Column(children: [Icon(Icons.error, size: 120)]));
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<JobOffer> jobOffer = snapshot.data;
              return ListView.builder(
                  itemCount: jobOffer.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.visibility_outlined,
                              color: Colors.black,
                              size: 28,
                            ),
                            title: Text(
                              jobOffer[index].title,
                              style: TextStyle(fontSize: 17.0),
                            ),
                            subtitle: Text(
                              jobOffer[index].subTitle,
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 70.0,
                              ),
                              Icon(Icons.phone),
                              Text(
                                jobOffer[index].phone,
                                style: TextStyle(fontSize: 12.0),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
