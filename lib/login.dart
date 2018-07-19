import 'package:flutter/material.dart';

import 'authenticationButtons.dart';

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
      backgroundColor: Colors.grey[200],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: AuthenticationButtons(),
      ),
    );
  }
}
