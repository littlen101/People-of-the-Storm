import 'package:flutter/material.dart';

import 'Login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _data = Firestore.instance;
  FirebaseUser _user;
  String displayName = 'Survivor';

  @override
  Widget build(BuildContext context) {
    void getUser() async {
      _user ??= await Navigator.of(context).push(
        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
          return Login(_auth);
        }),
      ) as FirebaseUser;

      DocumentSnapshot _snapShot = await _data
          .collection('users')
          .document('KzsMa0nyKKdQULuwrjqV')
          .get();

      String _name = _snapShot['${_user.uid}'];
      print(_name);
      setState(() {
        displayName = _name;
      });
    }

    void updateUser() {
      if (_user.displayName == null) {
        setState(() {
          displayName = _user.displayName;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Home $displayName',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: updateUser,
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment(0.0, 0.0),
        color: Colors.white70,
        child: MaterialButton(
          elevation: 3.0,
          color: Colors.grey,
          onPressed: getUser,
          splashColor: Colors.amber,
          child: Text('Punch Me please'),
        ),
      ),
    );
  }
}
