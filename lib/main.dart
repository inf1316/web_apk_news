import 'package:flutter/material.dart';
import 'package:web_apk_news/detail.dart';
import 'package:web_apk_news/shared/listItem.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

import 'imageSlidersWidget.dart';
import 'listWidget.dart';

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

  List<CustomTab> _tabList = [
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
      title: "Cartelera",
    ),
    CustomTab(
      title: "Pronosticos",
    ),
    CustomTab(
      title: "Perdidas-Hallazgo",
    ),
  ];

  TabController _tabController;
  CustomTab _myHandler;
  @override
  void initState() {
    // TODO: implement initState
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
    // TODO: implement dispose
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
                      onTap: () {},
                      child: new Padding(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        child: Card(
                            elevation: 8.0,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(16.0),
                            ),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ClipRRect(
                                  child: new ImageSliders(),
                                  borderRadius: BorderRadius.only(
                                      topLeft: new Radius.circular(16.0),
                                      topRight: new Radius.circular(16.0)),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.all(16.0),
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "This is title Text".toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      new SizedBox(
                                        height: 16.0,
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Text("19 March 2021"),
                                          new Text("10 min"),
                                          new Text("125k views")
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends Tab {
  final String title;
  CustomTab({this.title}) : super(child: Text(title));
}
