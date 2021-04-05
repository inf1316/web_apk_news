import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobOffers extends StatefulWidget {
  const JobOffers({Key key}) : super(key: key);

  @override
  _JobOffersState createState() => _JobOffersState();
}

class _JobOffersState extends State<JobOffers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
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
                        "Universidad de Cienfuegos",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      subtitle: Text(
                        "Ofrece plaza de custudio, salario minimo "
                        "persona en excelente condicion fisica,"
                        "sin antecedente penal",
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
                          "+595 (0982472329)",
                          style: TextStyle(fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
