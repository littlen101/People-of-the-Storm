import 'package:flutter/material.dart';

import '_authenticationButtons.dart';

class Login extends StatelessWidget {
  @override
  build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.purple[900],
      title: Text(
        'People of the Storm',
        style: Theme.of(context).textTheme.display1,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: authenticationButtons(),
      ),
    );
  }
}
