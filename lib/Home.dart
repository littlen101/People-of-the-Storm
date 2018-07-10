import 'package:flutter/material.dart';

import 'Login.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  FirebaseUser _user;
  String displayName = 'Survivor';

  void getUser() async {
    _user ??= await Navigator.push(context,
        MaterialPageRoute<FirebaseUser>(builder: (BuildContext context) {
      return Login();
    }));

    setState(() {
      displayName = _user.displayName;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) getUser();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Home $displayName',
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment(0.0, 0.0),
        color: Colors.white70,
        child: MaterialButton(
          elevation: 3.0,
          color: Colors.grey,
          onPressed: () => print('Happy'),
          splashColor: Colors.amber,
          child: Text('Punch Me please'),
        ),
      ),
    );
  }
}
