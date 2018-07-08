import 'package:flutter/material.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final _authenticationProviders = ['Email', 'Facebook', 'Google', 'Sign-up'];

final _authenticationColors = [
  {'background': Colors.grey[700], 'text': Colors.white},
  {'background': Colors.blue[800], 'text': Colors.white}, //Blue should be [800]
  {'background': Colors.redAccent, 'text': Colors.white},
  {'background': Colors.grey[700], 'text': Colors.white},
];

final _authenticationMethods = [
  _emailMethod,
  _facebookMethod,
  _googleMethod,
  _signupMethod,
];

final _emailMethod = () => print('Email Tapped');

Future<FirebaseUser> _facebookMethod() async {
  var facebookLogin = new FacebookLogin();
  var result = await facebookLogin.logInWithReadPermissions(['email']);

  FirebaseUser user = await _auth.signInWithFacebook(
    accessToken: result.accessToken.token,
  );

  print("signed in " + user.displayName);
  return user;
}

final _signupMethod = () => print('SignUp Tapped');

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: [
    'email',
  ],
);

Future<FirebaseUser> _googleMethod() async {
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  print("signed in " + user.displayName);
  return user;
}

Widget authenticationButtons() {
  final _buttonList = ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      var _authProvider = _authenticationProviders[index];
      var _authColor = _authenticationColors[index];
      var _authMethod = _authenticationMethods[index];

      return Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: RaisedButton(
            onPressed: () {
              _authMethod();
            },
            color: _authColor['background'],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Text(
                _authProvider,
                style: TextStyle(
                  color: _authColor['text'],
                  fontSize: 35.0,
                ),
              ),
            ),
          ),
        ),
      );
    },
    itemCount: _authenticationProviders.length,
  );

  return _buttonList;
}
