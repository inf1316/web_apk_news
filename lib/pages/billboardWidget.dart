import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    // select day WeekdaySelector
    var date = DateTime.now();
    var day = date.weekday;
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
              child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            ListTile(
                              leading: Text("12:30 PM"),
                              title: Text(
                                'A buena hora',
                                style: TextStyle(fontSize: 22.0),
                              ),
                              subtitle: Text(
                                'Salud de primera mano.',
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ),
                            // See more: https://stackoverflow.com/questions/55259142/flutter-how-to-align-widget-to-the-topright-of-column
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {},
                                icon:
                                    Icon(Icons.add_alert, color: Colors.indigo),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
                  }),
            )),
          ],
        )));
  }
}
