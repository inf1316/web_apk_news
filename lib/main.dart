import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Perlavisión Noticias', home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.00),
        child: AppBar(
          title: Text('Perlavisión'),
          backgroundColor: Colors.blue,
          leadingWidth: 38,
        ),
      ),
      body: Center(
          child: Center(
        child: Text('Mi contenido'),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Telecentro Perlavisión"),
              accountEmail: Text("perlavision@gmail.com"),
              currentAccountPicture:
                  CircleAvatar(backgroundColor: Colors.white),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Portada'),
              leading: Icon(Icons.home),
              onLongPress: () => {print("Presiono")},
            ),
            ListTile(
              title: Text('Notcias'),
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Clasificados'),
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Cartelera'),
              leading: Icon(Icons.home),
            ),
          ],
        ),
      ),
    );
  }
}
