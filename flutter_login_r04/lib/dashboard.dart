import 'package:flutter/material.dart';
import 'package:flutter_login_r04/helpers/dbhelper.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map<String, dynamic> recordUser;
  @override
  Widget build(BuildContext context) {
    //terima argument dalam bentuk int
    recordUser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard "),
        actions: [
          IconButton(
              onPressed: () {
                //reloaduserData();
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
                      "Welcome ${recordUser['username']} ", //+ (_user != null ? _user.username : 'user'
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Text(
                    "User Id : ${recordUser['id']}", // $_userId
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "User Email : ${recordUser['email']} ", // + (_user != null ? _user.email : 'email')
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
              Navigator.pushNamed(context, '/setting',
                  arguments: recordUser['id']); //navigasi ke settings
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
              children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Dashboard',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
              ],
            ),
          ))),
    );
  }
}
