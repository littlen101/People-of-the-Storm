import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class EmailLoginRoute extends StatefulWidget {
  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLoginRoute> {
  final _formKey = GlobalKey<FormState>();

  String _passwordValidator(String value) {
    if (value.length < 8)
      return "Please enter a password at least 8 characters long";

    return null;
  }

  String _emailValidator(String value) {
    if (value.contains("@") && value.contains('.')) return null;

    return "Please enter a valid Email";
  }

  @override
  Widget build(BuildContext context) {
    String _email;
    String _passwd;
    String _phTheme;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/launch_image.png'),
          fit: BoxFit.cover,
          color: Colors.black54,
          colorBlendMode: BlendMode.darken,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Theme(
                data: ThemeData(
                  textSelectionColor: Colors.white,
                  brightness: Brightness.light,
                  primarySwatch: Colors.purple,
                  textTheme: Theme.of(context).textTheme,
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 90.0,
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'you@email.com',
                          labelText: 'Email',
                          fillColor: Colors.transparent,
                          filled: true,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'passWrd',
                          labelText: 'Password',
                          filled: true,
                        ),
                        validator: _passwordValidator,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onSaved: (String value) => _phTheme = value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a Snackbar
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Logining in to User Account')));

                            _formKey.currentState.save();

                            FirebaseUser user =
                                await _auth.signInWithEmailAndPassword(
                                    email: _email, password: _phTheme);

                            Navigator.of(context).pop(user);
                          }
                        },
                        child: Text('Login'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
