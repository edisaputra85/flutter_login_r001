import 'package:flutter/material.dart';

import 'models/user.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    //terima argument dalam bentuk map
    Map<String, dynamic> userLogin = ModalRoute.of(context).settings.arguments;
    User user = userLogin['user'];
    int userId = userLogin['userId'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Welcome " + user.username,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Text(
                    "User Id : $userId",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              )),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log out"),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      )),
      body: Container(
          constraints: BoxConstraints.expand(),
          // is used to create container full screen with filled content.
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
          ),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ))),
    );
  }
}
