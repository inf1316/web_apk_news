import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/service/lostFindingApiService.dart';
import 'package:web_apk_news/shared/lostFinding.dart' as Lost;

class LostFinding extends StatefulWidget {
  const LostFinding({Key key}) : super(key: key);

  @override
  _LostFindingState createState() => _LostFindingState();
}

class _LostFindingState extends State<LostFinding> {
  final LostFindingApiService apiService = LostFindingApiService();

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
          builder: (context, AsyncSnapshot<List<Lost.LostFinding>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Column(children: [Icon(Icons.error, size: 120)]));
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Lost.LostFinding> lostFinding = snapshot.data;
              return ListView.builder(
                  itemCount: lostFinding.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.add_alert,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Text(
                              lostFinding[index].titular,
                              style: TextStyle(fontSize: 20.0),
                            ),
                            subtitle: Text(
                              lostFinding[index].description,
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
                                lostFinding[index].contactDetails,
                                style: TextStyle(fontSize: 15.0),
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
