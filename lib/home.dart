import 'package:flutter/material.dart';

import 'login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  Firestore _data = Firestore.instance;
  FirebaseUser _user;
  String displayName = 'Survivor';

  static const String _userCollection = 'users';
  static const String _emailDocument = 'KzsMa0nyKKdQULuwrjqV';

  @override
  Widget build(BuildContext context) {
    void getUser() async {
      _user ??= await Navigator.of(context).push(
        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
          return Login();
        }),
      ) as FirebaseUser;

      DocumentSnapshot _snapShot = await _data
          .collection(_userCollection)
          .document(_emailDocument)
          .get();

      String _name = _user.displayName ?? _snapShot['${_user.uid}'];

      setState(() {
        displayName = _name;
      });
    }

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
          onPressed: getUser,
          splashColor: Colors.amber,
          child: Text('Punch Me please'),
        ),
      ),
    );
  }
}
