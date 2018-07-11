import 'package:flutter/material.dart';

import '_authenticationButtons.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  final FirebaseAuth _auth;

  const Login(this._auth) : assert(_auth != null);

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
        child: AuthenticationButtons(_auth),
      ),
    );
  }
}
