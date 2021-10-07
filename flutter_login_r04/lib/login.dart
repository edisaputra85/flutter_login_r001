import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  bool validateLogin() {
    FormState form = this.formKey.currentState;
    return form.validate();
  }

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
                      'LOGIN',
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
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'username',
                                          labelText: 'Username',
                                          icon: Icon(Icons.person),
                                        ),
                                        validator: (String value) {
                                          if (value.isEmpty)
                                            return 'Username tidak boleh kosong';
                                          else
                                            return '';
                                        }),
                                    TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'password',
                                          labelText: 'Password',
                                          icon: Icon(Icons.lock),
                                        ),
                                        controller: passwordController,
                                        obscureText: true,
                                        validator: (String value) {
                                          if (value.isEmpty)
                                            return 'Password tidak boleh kosong';
                                          else
                                            return '';
                                        })
                                  ],
                                ),
                              )),
                          Expanded(
                              child: FloatingActionButton(
                            onPressed: () {
                              validateLogin();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Your password is ${passwordController.text}"),
                                  backgroundColor: Colors.green));
                            },
                            child: Icon(Icons.login),
                          ))
                        ])),
                Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: Text('Forgot Password?'))),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Register'))
              ],
            ),
          ))),
    );
  }
}
