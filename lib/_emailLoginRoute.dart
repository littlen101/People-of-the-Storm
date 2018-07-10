import 'package:flutter/material.dart';

class EmailLoginRoute extends StatefulWidget {
  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLoginRoute> {
  String _email;
  String _hpDisplay;
  String _displayName;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/splash.png'),
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
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 1.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          labelText: 'Password',
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a Snackbar
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
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
