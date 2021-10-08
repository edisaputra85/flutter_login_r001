import 'package:flutter/material.dart';
import 'package:flutter_login_r04/helpers/dbhelper.dart';

import 'models/user.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User user;
  int userId;

  void reloaduserData() {
    DbHelper dbHelper = new DbHelper();
    dbHelper.selectUserOnId(userId).then((mapList) {
      mapList.forEach((element) {
        setState(() {
          user = User.fromMap(element);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //terima argument dalam bentuk map
    Map<String, dynamic> userLogin = ModalRoute.of(context).settings.arguments;
    userId = userLogin['userId'];
    reloaduserData();

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard "),
        actions: [
          IconButton(
              onPressed: () {
                reloaduserData();
              },
              icon: Icon(Icons.refresh))
        ],
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
                  Text(
                    "User Email : " + user.email,
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
            onTap: () {
              Navigator.pop(context); //tutup drawer
              Navigator.pushNamed(context, '/settings',
                  arguments: userId); //navigasi ke settings
            },
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
