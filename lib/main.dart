import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:draggable_floating_button/draggable_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/pages/imageListWidget.dart';
import 'package:web_apk_news/pages/jobOffersWidget.dart';
import 'package:web_apk_news/pages/lostFindingWidget.dart';
import 'package:web_apk_news/pages/newsWidget.dart';
import 'custom/customHttpOverrides.dart';
import 'custom/notificationPush.dart';
import 'pages/billboardWidget.dart';
import 'package:web_apk_news/shared/customTab.dart';

Future<void> fireAlarm() async {
  await NotificationPush.notification();
  print('Alarm Fired at ${DateTime.now()}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new CustomHttpOverrides();
  await AndroidAlarmManager.initialize();

  await AndroidAlarmManager.periodic(
      const Duration(minutes: 1), Random().nextInt(pow(2, 31)), fireAlarm,
      exact: true, wakeup: true);

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
      appBar: getAppBar(),
      body: TabBarView(controller: _tabController, children: [
        News(present: true),
        News(present: false),
        ImageList(),
        JobOffers(),
        BillBoard(),
        LostFinding(),
      ]),
      floatingActionButton: Stack(children: [
        Container(
          alignment: Alignment.bottomRight,
          child: DraggableFloatingActionButton(
              backgroundColor: Colors.white,
              child: new Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {});
              },
              appContext: context,
              appBar: getAppBar()),
        ),
      ]),
    );
  }

  Widget getAppBar() {
    return AppBar(
      toolbarHeight: 95.0,
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
    );
  }
}
