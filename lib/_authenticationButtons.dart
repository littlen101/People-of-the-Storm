import 'package:flutter/material.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import '_emailLoginRoute.dart';

class AuthenticationButtons extends StatelessWidget {
  final _authenticationProviders = ['Email', 'Facebook', 'Google', 'Sign-up'];

  final _authenticationColors = [
    {'background': Colors.grey[700], 'text': Colors.white},
    {
      'background': Colors.blue[800],
      'text': Colors.white
    }, //Blue should be [800]
    {'background': Colors.redAccent, 'text': Colors.white},
    {'background': Colors.grey[700], 'text': Colors.white},
  ];

  final FirebaseAuth _auth;

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

  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  AuthenticationButtons(this._auth) : assert(_auth != null);

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

  Widget _authenticationButtons(List<Function> _authenticationMethods) {
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
                Navigator.of(context).pop(_authMethod());
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

  @override
  Widget build(BuildContext context) {
    Future<FirebaseUser> _emailMethod() async {
      FirebaseUser user = await Navigator.of(context).push(
          MaterialPageRoute<FirebaseUser>(builder: (BuildContext context) {
        return Scaffold(
          body: EmailLoginRoute(),
        );
      }));

      return user;
    }

    final _authenticationMethods = [
      _emailMethod,
      _facebookMethod,
      _googleMethod,
      _signupMethod,
    ];

    return _authenticationButtons(_authenticationMethods);
  }
}
