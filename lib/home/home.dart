import 'package:flutter/material.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pos/authentication/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
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

  void listenForUser(FirebaseUser user) async {
    if (user != null) {
      setState(() {
        _user = user;
        updateDisplayName();
      });
    } else {
      FirebaseUser _userSave = await Navigator.of(context).push(_getRoute());
      setState(() {
        _user = _userSave;
      });
      updateDisplayName();
    }
  }

  void updateUser() {
    print('in');
    _auth.currentUser().then((FirebaseUser user) {
      setState(() {
        _user = user;
      });
    });
  }

  void updateDisplayName() {
    print(_user);
    setState(() {
      if (_user != null)
        displayName = _user?.displayName ?? _returnDisplayName();
      else
        displayName = 'Survivor';
    });
  }

  Route<dynamic> _getRoute() {
    return MaterialPageRoute<FirebaseUser>(
      builder: (BuildContext context) => Login(
            auth: _auth,
          ),
      fullscreenDialog: true,
    );
  }

  @override
  void initState() {
    super.initState();
    updateUser();
    updateDisplayName();
    _auth.onAuthStateChanged.listen(listenForUser);
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
          onPressed: () async {
            await _auth.signOut();
            updateUser();
            updateDisplayName();
          },
          splashColor: Colors.amber,
          child: Text('Punch Me please'),
        ),
      ),
    );
  }
}
