import 'package:flutter/material.dart';

import '_authenticationButtons.dart';

class Login extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage("assets/images/purpleClouds.jpg"),
          fit: BoxFit.fitWidth,
          width: 300.0,
        ),
        Container(
          color: Colors.grey[700],
          padding: EdgeInsets.all(16.0),
          child: authenticationButtons(),
        )
      ],
    );
  }
}
