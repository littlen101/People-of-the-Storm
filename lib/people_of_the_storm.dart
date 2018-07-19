import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';
import 'login.dart';

class PeopleOfStorm extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  PeopleOfStormState createState() {
    return new PeopleOfStormState();
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: Colors.purple,
      textTheme: _buildTextTheme(),
    );
  }

  TextTheme _buildTextTheme() {
    return TextTheme(
      display1: TextStyle(
        color: Colors.white,
      ),
      display2: TextStyle(
        color: Colors.black,
      ),
      display3: TextStyle(
        color: Colors.blue,
      ),
      display4: TextStyle(
        color: Colors.amber,
      ),
      headline: TextStyle(
        color: Colors.lightGreen,
      ),
    );
  }
}

class PeopleOfStormState extends State<PeopleOfStorm> {
  FirebaseUser _user;

  void _getCurrentUser() async {
    _user ??= await widget._auth.currentUser();
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'People of the Storm',
      theme: widget._buildTheme(),
      home: Home(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') return null;
    _getCurrentUser();
    if (_user != null) return null;

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => Login(),
      fullscreenDialog: true,
    );
  }
}
