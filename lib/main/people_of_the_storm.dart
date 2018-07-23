import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:pos/home/home.dart';
import 'package:pos/authentication/login.dart';

/// Main app class which defines the theme and flow for a user
class PeopleOfStorm extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Creation of the app state
  @override
  _PeopleOfStormState createState() => _PeopleOfStormState();

  // Primary theme of the app that uses colors inspired from
  ThemeData _buildTheme() {
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      primaryColor: Colors.purple,
      buttonColor: Colors.purple[900],
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textTheme: ButtonTextTheme.accent,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }

  // TextThemes that allow clear legibility of words on backgrounds and in
  // what ever context
  TextTheme _buildTextTheme(TextTheme base) {
    // currently all random
    return base.copyWith(
      headline: base.headline.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: base.title.copyWith(fontSize: 18.0),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
      body2: base.body2.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    );
  }
}

class _PeopleOfStormState extends State<PeopleOfStorm> {
  FirebaseUser _user;
  void _getCurrentUser() async {
    _user ??= await widget._auth.currentUser();
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'People of the Storm',
      theme: widget._buildTheme(),
      home: Home(auth: widget._auth),
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
      builder: (BuildContext context) => Login(
            auth: widget._auth,
          ),
      fullscreenDialog: true,
    );
  }
}
