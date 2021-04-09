import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/service/billboardApiService.dart';
import 'package:web_apk_news/shared/billboard.dart';
import 'package:weekday_selector/weekday_selector.dart';

class BillBoard extends StatefulWidget {
  const BillBoard({Key key}) : super(key: key);

  @override
  _BillBoardState createState() => _BillBoardState();
}

class _BillBoardState extends State<BillBoard> {
  // weekDay
  var values = List.filled(7, false);
  var notification = false;
  final BillboardApiService apiService = BillboardApiService();
  int day = 0;

  @override
  void initState() {
    super.initState();

    // select day WeekdaySelector
    var date = DateTime.now();
    day = date.weekday;

    values = List.filled(7, false, growable: false)
      ..[day == 7 ? 0 : day] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            // See more: https://pub.dev/packages/weekday_selector
            WeekdaySelector(
                onChanged: (int day) {
                  setState(() {
                    values = List.filled(7, false, growable: false)
                      ..[day == 7 ? 0 : day] = true;
                    this.day = day;
                  });
                },
                selectedFillColor: Colors.indigo,
                values: values,
                shortWeekdays: ["D", "L", "M", "M", "J", "V", "S"]),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              child: FutureBuilder(
                future: apiService.getAll(day),
                builder: (context, AsyncSnapshot<List<BillBoards>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child:
                            Column(children: [Icon(Icons.error, size: 120)]));
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<BillBoards> billboard = snapshot.data;
                    return Container(
                      child: ListView.builder(
                          itemCount: billboard.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(children: [
                                    ListTile(
                                      leading: Text(billboard[index].hours),
                                      title: Text(
                                        billboard[index].title,
                                        style: TextStyle(fontSize: 22.0),
                                      ),
                                      subtitle: Text(
                                        billboard[index].subtitle,
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.add_alert,
                                            color: Colors.indigo),
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )),
          ],
        )));
  }
}
