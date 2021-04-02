import 'package:flutter/material.dart';
import 'package:web_apk_news/imageCardWidget.dart';
import 'package:web_apk_news/jobOffersWidget.dart';
import 'package:web_apk_news/shared/imageCard.dart';
import 'package:web_apk_news/shared/jobOffer.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'listWidget.dart';
import 'package:web_apk_news/detailWidget.dart';
import 'package:web_apk_news/shared/customTab.dart';
import 'package:web_apk_news/shared/listItem.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Perlavisión Noticias',
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  CustomTab _myHandler;

  final values = List.filled(7, false);

  // tab control
  final List<CustomTab> _tabList = [
    CustomTab(
      title: "Portada",
    ),
    CustomTab(
      title: "Noticias",
    ),
    CustomTab(
      title: "Galería Imagenes",
    ),
    CustomTab(
      title: "Ofertas Laborales",
    ),
    CustomTab(
      title: "Cartelera",
    ),
    CustomTab(
      title: "Perdidas-Hallazgo",
    )
  ];

  // hard code for moment
  List<ListItem> listTile = [
    ListItem(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020"),
    ListItem(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020"),
    ListItem(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020"),
    ListItem(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020"),
    ListItem(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020"),
    ListItem(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020"),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabList.length, vsync: this);
    _myHandler = _tabList[0];

    // See more: https://stackoverflow.com/questions/46891916/flutter-change-main-appbar-title-on-other-pages
    _tabController.addListener(_handleSelected);
  }

  void _handleSelected() {
    setState(() {
      _myHandler = _tabList[_tabController.index];
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: true,
        title: Text(
          _myHandler.title,
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            isScrollable: true,
            controller: _tabController,
            tabs: _tabList,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 100,
              child: ListView.builder(
                itemCount: _tabList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    item: listTile[index],
                                    tag: listTile[index].newsTitle)));
                      },
                      child: listWidget(listTile[index]));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 100,
              child: ListView.builder(
                itemCount: _tabList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    item: listTile[index],
                                    tag: listTile[index].newsTitle)));
                      },
                      child: listWidget(listTile[index]));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              width: 100,
              child: new ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: new Padding(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        child: ImageCard(
                          imageListCard: ImageListCard("This title Image",
                              "19 March 2021", "10 min", "125k views", null),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return JobOffers(
                          jobOffer: JobOffer(
                              "Universidad de Cienfuegos",
                              "Ofrece plaza de custudio, salario minimo, "
                                  "persona en excelente condicion fisica,"
                                  "sin antecedente penal",
                              "+595 (0982472329)"));
                    })),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  child: Column(
                children: [
                  // See more: https://pub.dev/packages/weekday_selector
                  WeekdaySelector(
                    onChanged: (int day) {
                      setState(() {
                        final index = day % 7;
                        values[index] = !values[index];
                      });
                    },
                    values: values,
                  ),
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
                                      onPressed: () {
                                        
                                      },
                                      icon: Icon(
                                        Icons.add_alert,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ));
                        }),
                  )),
                ],
              ))),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
        ],
      ),
    );
  }
}
