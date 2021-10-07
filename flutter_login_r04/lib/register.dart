import 'package:flutter/material.dart';
import 'package:flutter_login_r04/helpers/dbhelper.dart';

import 'models/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  DbHelper dbHelper = new DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Register',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: 'username',
                                    labelText: 'Username',
                                    icon: Icon(Icons.person),
                                  ),
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    labelText: 'Password',
                                    icon: Icon(Icons.lock),
                                  ),
                                  obscureText: true,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'email',
                                    labelText: 'Email',
                                    icon: Icon(Icons.email),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: FloatingActionButton(
                            onPressed: () {
                              //form validasi
                              //baca isian form dan simpan ke objek user
                              User user = new User(
                                  usernameController.text,
                                  passwordController.text,
                                  emailController.text);

                              //insert objek user ke dalam tabel users di SQLite
                              dbHelper.insertUser(user).then((count) {
                                if (count > 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Registrasi Sukses"),
                                          backgroundColor: Colors.green));
                                  Navigator.pushNamed(context, '/login');
                                } else
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Reistrasi gagal"),
                                          backgroundColor: Colors.red));
                              });
                            },
                            child: Icon(Icons.send),
                          ))
                        ])),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Back to Login'))
              ],
            ),
          ))),
    );
  }
}
