import 'package:flutter/material.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:pos/authentication/emailLoginRoute.dart';

/// A class that defines the authentication methods of the supported provider,
/// and also provides a method to generate a list of [AuthenticationButton]s
class LoginAuthenticationButtons {
  // Not completely sure how the FirebaseAuth.instance works; assuming it takes
  // the session instance every time;
  //  --- Based off the way onAuthChange seems like i need to pass the instance
  //  --- around
  final FirebaseAuth auth;
  // Currently supporting three authentication methods
  // Facebook, Google, and Email
  final _authenticationProviders = ['Facebook', 'Google', 'Email'];
  final Map<String, ThemeData> _authenticationThemes = {
    'Email': ThemeData(
      primaryColor: Colors.grey[700],
      textTheme: TextTheme(
        display1: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    'Facebook': ThemeData(
      primaryColor: Color(0xFF3B5998), //Facebook Blue
      textTheme: TextTheme(
        display1: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    'Google': ThemeData(
      primaryColor: Color(0xFFdb3236), //Google Red
      textTheme: TextTheme(
        display1: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  };

  /// Needed to work with the Navigator
  final BuildContext context;

  /// Standard button to return the user back to the previous screen
  /// Need to figure out how to catch the android nav bar escape
  AuthenticationButton returnButton(BuildContext context) {
    return AuthenticationButton(
      name: 'return',
      theme: ThemeData(
        primaryColor: Colors.transparent, //Facebook Blue
        textTheme: TextTheme(
          display1: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  LoginAuthenticationButtons({
    @required this.context,
    @required this.auth,
  }) : assert(context != null);

  // Standard Facebook Authentication flow taken from the Firebase Docs
  void _facebookMethod() async {
    FirebaseUser user;
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logInWithReadPermissions(['email']);

      user = await auth.signInWithFacebook(
        accessToken: result.accessToken.token,
      );
    } catch (e) {
      print('unsucessful authentication');
    }

    Navigator.of(context).pop(user);
  }

  // Required to use FirebaseAuth authentication with google
  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  // Standard Google authentication flow taken from FireBase Docs
  void _googleMethod() async {
    FirebaseUser user;
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser?.authentication;
      user = await auth.signInWithGoogle(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
    } catch (e) {
      print('unsucessful authentication');
    }

    Navigator.of(context).pop(user);
  }

  // Email authentication flow
  // Takes user to alternate Route for signing in with email and password
  void _emailMethod() async {
    FirebaseUser user = await showDialog(
        context: context,
        builder: (BuildContext context) {
          final _formKey = GlobalKey<FormState>();
          final _emailController = TextEditingController();
          final _passwordController = TextEditingController();

          String _passwordValidator(String value) {
            if (value.length < 8)
              return "Please enter a password at least 8 characters long";

            return null;
          }

          String _emailValidator(String value) {
            if (value.contains("@") && value.contains('.')) return null;

            return "Please enter a valid Email";
          }

          return SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                'Sign-in',
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'you@email.com',
                        labelText: 'Email',
                        filled: true,
                      ),
                      controller: _emailController,
                      validator: _emailValidator,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                      ),
                      controller: _passwordController,
                      validator: _passwordValidator,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.of(context).pop();
                  },
                ),
                RaisedButton(
                  child: Text('NEXT'),
                  elevation: 8.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () async {
                    FirebaseUser user;
                    bool _successful = true;
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      try {
                        user = await auth.signInWithEmailAndPassword(
                            email: _emailController.value.text,
                            password: _passwordController.value.text);
                      } catch (e) {
                        print('Failed');
                        _successful = false;
                      }

                      if (_successful) Navigator.of(context).pop(user);
                    }
                  },
                ),
              ],
            ),
          );
        });

    Navigator.of(context).pop(user);
  }

  /// Creates a list of usable [AuthenticationButton]s for the requester to
  /// display. Provides flexibility on which buttons to include.
  List<AuthenticationButton> generate(
      {bool includeEmail = true, bool includeReturn = true}) {
    // To access the methods and not have each method be static
    // The mapping is created in the instance method
    Map<String, Function> _authenticationMethods = {
      'Email': _emailMethod,
      'Facebook': _facebookMethod,
      'Google': _googleMethod,
    };

    List<AuthenticationButton> buttons = List.generate(
      _authenticationProviders.length,
      (int index) {
        return AuthenticationButton(
          name: _authenticationProviders[index],
          theme: _authenticationThemes[_authenticationProviders[index]],
          onPressed: _authenticationMethods[_authenticationProviders[index]],
        );
      },
    );

    if (!includeEmail) buttons.removeLast();
    if (includeReturn) buttons.add(returnButton(context));

    return buttons;
  }
}

/// A standardized button style for all authentication providers
/// which represents a flexible and reusable template
class AuthenticationButton extends StatelessWidget {
  /// Name of the authentication provider
  final String name;

  /// The specific theme associated with the provider
  final ThemeData theme;

  /// The given authentication flow for the provider
  final Function onPressed;

  AuthenticationButton({
    @required this.name,
    @required this.theme,
    @required this.onPressed,
  }) : assert(theme != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50.0,
        width: 125.0,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: onPressed,
          color: theme.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              name,
              style: theme.textTheme.display1,
            ),
          ),
        ),
      ),
    );
  }
}
