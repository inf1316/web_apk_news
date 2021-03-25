import 'package:flutter/material.dart';

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
  List<Tab> _tabList = [
    Tab(
      child: Text("Portada"),
    ),
    Tab(
      child: Text("Noticias"),
    ),
    Tab(
      child: Text("Promociones"),
    ),
    Tab(
      child: Text("Cartelera"),
    ),
    Tab(
      child: Text("Pronosticos"),
    ),
    Tab(
      child: Text("Perdidas-Hallazgo"),
    ),
  ];

  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
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
          "Noticias",
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
              padding: EdgeInsets.all(8.0),
              child: Container(
              ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
            ),
          ),
        ],
      ),
    );
  }
}
