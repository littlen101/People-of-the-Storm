import 'package:flutter/material.dart';

import 'package:pos/home/home.dart';

/// Main app class which defines the theme and flow for a user
class PeopleOfStorm extends StatefulWidget {
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
  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'People of the Storm',
      theme: widget._buildTheme(),
      home: Home(),
    );
  }
}
