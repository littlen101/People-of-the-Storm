import 'package:flutter/material.dart';

import 'Home.dart';

void main() => runApp(PeopleOfStorm());

class PeopleOfStorm extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'People of the Storm',
      theme: ThemeData(
        textTheme: TextTheme(
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
        ),
      ),
      home: Home(),
    );
  }
}
