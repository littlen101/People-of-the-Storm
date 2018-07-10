import 'package:flutter/material.dart';

class EmailLoginRoute extends StatefulWidget {
  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLoginRoute> {
  String _email;
  String _hpDisplay;
  String _displayName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/splashScreen.png'),
          fit: BoxFit.cover,
          color: Colors.black54,
          colorBlendMode: BlendMode.darken,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/logo.gif'),
            ),
            Form(
              child: Theme(
                data: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.purple[800],
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
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
