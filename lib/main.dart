import 'package:flutter/material.dart';

import 'Login.dart';

void main() => runApp(PeopleOfStorm());

class PeopleOfStorm extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'People of the Storm',
      theme: ThemeData(
        fontFamily: "Roboto",
        primarySwatch: MaterialColor(900, {
          50: Colors.purple[50],
          100: Colors.purple[100],
          200: Colors.purple[200],
          900: Colors.purple[900]
        }),
      ),
      home: Login(),
    );
  }
}
