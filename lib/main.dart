import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_apk_news/pages/imageListWidget.dart';
import 'package:web_apk_news/pages/jobOffersWidget.dart';
import 'package:web_apk_news/pages/lostFindingWidget.dart';
import 'package:web_apk_news/pages/newsWidget.dart';
import 'package:workmanager/workmanager.dart';
import 'custom/customHttpOverrides.dart';
import 'pages/billboardWidget.dart';
import 'package:web_apk_news/shared/customTab.dart';

void main() {
  // See more : https://www.geeksforgeeks.org/background-local-notifications-in-flutter/
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager.registerPeriodicTask(
    "2",
    "simplePeriodicTask",
    frequency: Duration(minutes: 15),
  );
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
      title: "Galerías",
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
          toolbarHeight: 95.0,
          leading: IconButton(
            onPressed: () {

            },
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
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.more_vert, color: Colors.black),
              onPressed: () => print('hi on icon action'),
            ),
          ],
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
        body: TabBarView(controller: _tabController, children: [
          News(present: true),
          News(present: false),
          ImageList(),
          JobOffers(),
          BillBoard(),
          LostFinding()
        ]),
        floatingActionButton: Container(
          width: 50.0,
          height: 50.0,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            child: const Icon(Icons.refresh, color: Colors.black),
            backgroundColor: Colors.white,
          ),
        ));
  }
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();

    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();

    var settings = new InitializationSettings(android, IOS);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await flip.show(
      0,
      'GeeksforGeeks',
      'Your are one step away to connect with GeeksforGeeks',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}
