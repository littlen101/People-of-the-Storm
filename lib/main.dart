import 'package:flutter/material.dart';

import 'Login.dart';

void main() => runApp(StartUp());

class StartUp extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'People of the Storm',
      theme: ThemeData(
        fontFamily: "Roboto",
        primarySwatch: Colors.purple[900],
      ),
      home: Login(),
    );
  }
}
