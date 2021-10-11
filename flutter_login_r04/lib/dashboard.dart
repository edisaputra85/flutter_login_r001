import 'package:flutter/material.dart';
import 'package:flutter_login_r04/helpers/dbhelper.dart';
import 'package:intl/intl.dart';
import 'models/user.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User user;
  int userId;
  List<Map<String, dynamic>> mapList;
  DbHelper dbHelper = new DbHelper();

  void reloaduserData() {
    dbHelper.selectUserOnId(this.userId).then((mapList) {
      mapList.forEach((element) {
        setState(() {
          this.user = User.fromMap(element);
        });
      });
    });
    dbHelper.selectAllTugas().then((mapList) {
      setState(() {
        this.mapList = mapList;
      });
    });
  }

  ListView createListView() {
    if (this.mapList.length != null) {
      return ListView.builder(
        shrinkWrap:
            true, //harus tambahkan shrinkwrap, listview tidak boleh dibungkus dengan singlechildscroolview
        itemCount: mapList.length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.all(2),
              child: Card(
                child: Container(
                  color: getColor(index),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('Matakuliah ')),
                          Expanded(
                            flex: 2,
                            child: Text(mapList[index]['matakuliah']),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('Deadline ')),
                          Expanded(
                            flex: 2,
                            child: Text(DateFormat("dd MMMM y").format(
                                DateTime.parse(mapList[index]['deadline']))),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('Uraian Tugas ')),
                          Expanded(
                            flex: 2,
                            child: Text(
                              mapList[index]['uraian_tugas'],
                              maxLines: 5,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('Status Tugas ')),
                          Expanded(
                            flex: 2,
                            child: Text(mapList[index]['status']),
                          )
                        ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              onPressed: () {
                                //update record tugas berdasarkan id menjadi selesai dan set state element yang berubah
                                dbHelper.updateStatusTugas(
                                    mapList[index]['id'], 'selesai');
                                reloaduserData();
                              },
                              child: Text("Set Selesai")))
                    ],
                  ),
                ),
              ));
        },
      );
    } else {
      return ListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    //terima argument dalam bentuk map
    this.userId = ModalRoute.of(context).settings.arguments;
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
                      "Welcome " + this.user.username,
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
          child: Container(
            margin: EdgeInsets.all(10),
            child: createListView(),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tambahtugas', arguments: userId);
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Color getColor(int index) {
    if (this.mapList[index]['status'] == 'belum')
      return Colors.orange;
    else if (this.mapList[index]['status'] == 'selesai')
      return Colors.green;
    else
      return Colors.red;
  }
}
