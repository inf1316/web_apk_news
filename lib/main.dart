import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_apk_news/imageCardWidget.dart';
import 'package:web_apk_news/pages/jobOffersWidget.dart';
import 'package:web_apk_news/pages/newsWidget.dart';
import 'package:web_apk_news/shared/imageCard.dart';
import 'custom/customHttpOverrides.dart';
import 'pages/billboardWidget.dart';
import 'pages/newsListWidget.dart';
import 'file:///D:/www/yii2/Actuales/perlavision/web-apk-news/web_apk_news/lib/pages/newsDetailsWidget.dart';
import 'package:web_apk_news/shared/customTab.dart';
import 'package:web_apk_news/shared/newsList.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

void main() {
  HttpOverrides.global = new CustomHttpOverrides();
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
  List<NewsList> listTile = [
    NewsList(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020",
        ""),
    NewsList(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020",
        ""),
    NewsList(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020",
        ""),
    NewsList(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020",
        ""),
    NewsList(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020",
        ""),
    NewsList(
        "https://image.nuevayork.com/wp-content/uploads/2012/09/Times-Square-in-New-York.jpg",
        lipsum.createWord(numWords: 6),
        lipsum.createWord(numWords: 2),
        "28 Jan 2020",
        ""),
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
          News(),
          News(),
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
          JobOffers(),
          BillBoard(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
        ],
      ),
    );
  }
}
