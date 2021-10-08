import 'package:flutter/material.dart';
import 'package:flutter_login_r04/helpers/dbhelper.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  DbHelper dbHelper = new DbHelper();
  @override
  Widget build(BuildContext context) {
    //terima argument dalam bentuk int
    int userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
          constraints: BoxConstraints.expand(),
          // is used to create container full screen with filled content.
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    label: Text('New Password'),
                    hintText: 'input new password',
                  ),
                  obscureText: true,
                ),
                ElevatedButton(
                    onPressed: () {
                      dbHelper.updateUserPassword(
                          userId, passwordController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("update password sukses"),
                          backgroundColor: Colors.green));
                    },
                    child: Text('Update Password')),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text('New Email'),
                    hintText: 'input new email',
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      dbHelper.updateUserEmail(userId, emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("update email sukses"),
                          backgroundColor: Colors.green));
                    },
                    child: Text('Update Email')),
              ],
            ),
          ))),
    );
  }
}
