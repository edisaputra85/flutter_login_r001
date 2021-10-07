import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

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
                            onPressed: () {},
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
