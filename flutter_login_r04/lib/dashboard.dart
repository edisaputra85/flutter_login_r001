import 'package:flutter/material.dart';
import 'package:flutter_login_r04/helpers/dbhelper.dart';
import 'package:intl/intl.dart';
import 'models/user.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User _user;
  int _userId;

  //int userId;
  List<Map<String, dynamic>> _listTugas;
  DbHelper dbHelper = new DbHelper();

  void reloaduserData() {
    dbHelper.selectUserOnId(_userId).then((userList) {
      dbHelper.selectAllTugas().then((listTugas) {
        setState(() {
          _listTugas = listTugas;
          _user = User.fromMap(userList.elementAt(0));
        });
      });
    });
  }

  ListView createListView() {
    if (_listTugas != null) {
      return ListView.builder(
        shrinkWrap:
            true, //harus tambahkan shrinkwrap, listview tidak boleh dibungkus dengan singlechildscroolview
        itemCount: _listTugas.length,
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
                            child: Text(_listTugas[index]['matakuliah']),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('Deadline ')),
                          Expanded(
                            flex: 2,
                            child: Text(DateFormat("dd MMMM y").format(
                                DateTime.parse(_listTugas[index]['deadline']))),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('Uraian Tugas ')),
                          Expanded(
                            flex: 2,
                            child: Text(
                              _listTugas[index]['uraian_tugas'],
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
                            child: Text(_listTugas[index]['status']),
                          )
                        ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              onPressed: () {
                                //update record tugas berdasarkan id menjadi selesai dan set state element yang berubah
                                dbHelper.updateStatusTugas(
                                    _listTugas[index]['id'], 'selesai');
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
    _userId = ModalRoute.of(context).settings.arguments;
    if (_user == null) reloaduserData();

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
                      "Welcome " + (_user != null ? _user.username : 'user'),
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Text(
                    "User Id : $_userId",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "User Email : " + (_user != null ? _user.email : 'email'),
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
                  arguments: _userId); //navigasi ke settings
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
          Navigator.pushNamed(context, '/tambahtugas', arguments: _userId);
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  Color getColor(int index) {
    DateTime today = DateTime.now();
    bool isLewatWaktu = false;
    if (today.isAfter(DateTime.parse(_listTugas[index]['deadline']).add(Duration(
        days:
            1)))) //tambah satu krn batas wajtu hari yg sama tapi pkl 23.59, sehingga mendekati hari berikutnya
      isLewatWaktu = true;
    if (this._listTugas[index]['status'] == 'belum' && isLewatWaktu == false)
      return Colors.orange;
    else if (this._listTugas[index]['status'] == 'selesai')
      return Colors.green;
    else
      return Colors.red;
  }
}
