import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool icons = true;

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
                    List<BillBoards> billboards = snapshot.data;
                    return Container(
                      child: ListView.builder(
                          itemCount: billboards.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(children: [
                                    ListTile(
                                      leading: Text(billboards[index].hours),
                                      title: Text(
                                        billboards[index].title,
                                        style: TextStyle(fontSize: 22.0),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {
                                            savePreference(billboards[index]);
                                          },
                                          icon: obtainIcon(
                                              context, billboards[index])),
                                      subtitle: Text(
                                        billboards[index].subtitle,
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                    )
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

  Future<void> savePreference(BillBoards billBoard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(billBoard.title + billBoard.hours + day.toString(),
        billBoard.title + ";" + billBoard.hours + ";" + day.toString());
  }

  // See more : https://flutteragency.com/how-to-assign-future-to-a-widget-in-flutter/
  Widget obtainIcon(BuildContext context, BillBoards billBoard) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> notification) {
          String valueNotification;
          try {
            if (notification.data.containsKey(
                billBoard.title + billBoard.hours + day.toString())) {

              valueNotification = notification.data.getString(
                  billBoard.title + billBoard.hours + day.toString());
            }
          } on Exception catch (ex) {}

          if (valueNotification != null && valueNotification.isNotEmpty) {
            return Icon(Icons.add_alert, color: Colors.indigo);
          }
          return Icon(Icons.add, color: Colors.indigo);
        });
  }
}
