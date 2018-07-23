import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos/assets/animatedLogo.dart';

import 'loginAuthenticationButtons.dart';

class SignUpPage extends StatefulWidget {
  final POSLogoHero logo;
  final FirebaseAuth auth;

  SignUpPage({this.logo, this.auth});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static const String _userCollection = 'users';
  static const String _emailDocument = 'KzsMa0nyKKdQULuwrjqV';

  final Firestore _data = Firestore.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _passConfirmController = TextEditingController();
  String _passText;
  String _passConfirmText;
  String _emailText;
  bool _validate() {
    if (_passController.value.text.length >= 8) if (_passController
            .value.text ==
        _passConfirmController.value.text) {
      setState(() {
        _passText = null;
        _passConfirmText = null;
        _emailText = null;
      });
      return true;
    } else {
      setState(() {
        _passText = ' Passwords do not match';
        _passConfirmText = 'Passwords do not match';
      });
    }
    else {
      setState(() {
        _passText = 'Password needs to be at least 8 characters';
      });
    }

    return false;
  }

  void _createUser() async {
    String _email = _emailController.value.text;
    String _password = _passConfirmController.value.text;
    FirebaseUser _user = await widget.auth
        .createUserWithEmailAndPassword(email: _email, password: _password);
    _email = null;
    _password = null;

    UserUpdateInfo info = UserUpdateInfo();
    info.displayName = 'UserDisplay';

    _data.collection(_userCollection).document(_emailDocument).updateData({
      '${_user.uid}': 'AlertnativeTestName',
    });

    widget.auth.updateProfile(info);

    Navigator.of(context).pop(_user);
  }

  Widget authProvider() {
    List<AuthenticationButton> buttons =
        LoginAuthenticationButtons(auth: widget.auth, context: context)
            .generate(includeEmail: false, includeReturn: false);
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: buttons
                  .map((AuthenticationButton button) => Column(
                        children: <Widget>[
                          SizedBox(
                            height: 8.0,
                          ),
                          button,
                        ],
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget createAccount() {
    EdgeInsets _inputPadding = EdgeInsets.all(10.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Create Account',
          style: Theme.of(context).textTheme.headline,
        ),
        SizedBox(
          height: 4.0,
        ),
        Container(
          padding: _inputPadding,
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              filled: true,
              errorText: _emailText,
            ),
          ),
        ),
        Container(
          padding: _inputPadding,
          child: TextField(
            controller: _passController,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: _passText,
              filled: true,
            ),
            obscureText: true,
          ),
        ),
        Container(
          padding: _inputPadding,
          child: TextField(
            controller: _passConfirmController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              errorText: _passConfirmText,
              filled: true,
            ),
            obscureText: true,
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('cancel'),
            ),
            RaisedButton(
              onPressed: () {
                if (_validate()) _createUser();
              },
              child: Text('Sign-up'),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              width: 100.0,
              height: 100.0,
              alignment: Alignment.topLeft,
              child: Hero(tag: widget.logo.tag, child: widget.logo.child),
            ),
            Text(
              'Sign-up',
              style: Theme.of(context).textTheme.headline,
            ),
            authProvider(),
            createAccount(),
          ],
        ),
      ),
    );
  }
}
