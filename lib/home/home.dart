import 'package:flutter/material.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;

  Home({this.auth});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  Firestore _data = Firestore.instance;
  FirebaseUser _user;
  String displayName = 'Survivor';
  StreamSubscription<FirebaseUser> _userSub;

  static const String _userCollection = 'users';
  static const String _emailDocument = 'KzsMa0nyKKdQULuwrjqV';

  String _returnDisplayName() {
    String disName = 'Survivor';
    _data
        .collection(_userCollection)
        .document(_emailDocument)
        .get()
        .then((snapshot) {
      disName = snapshot['${_user.uid}'];
    });

    return disName;
  }

  @override
  void initState() {
    super.initState();
    _userSub = widget.auth.onAuthStateChanged.listen(listenForUser);
  }

  void listenForUser(FirebaseUser user) {
    setState(() {
      _user = user;
      displayName = _user?.displayName ?? _returnDisplayName();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => print('help'),
          splashColor: Colors.amber,
          child: Text('Punch Me please'),
        ),
      ),
    );
  }
}
