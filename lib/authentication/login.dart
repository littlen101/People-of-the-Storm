import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:pos/assets/animatedLogo.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'signUpPage.dart';
import 'loginPage.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;

  Login({@required this.auth});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final POSLogoHero logo =
      POSLogoHero(child: POSLogo(upDown: true), tag: 'login');

  void _pushLogin(BuildContext context) async {
    timeDilation = 2.0;
    FirebaseUser _user =
        await Navigator.of(context).push(PageRouteBuilder<FirebaseUser>(
            opaque: true,
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                LoginPage(
                  logo: logo,
                  context: context,
                  auth: widget.auth,
                ),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
                child: child,
              );
            }));

    Navigator.of(context).pop(_user);
  }

  void _pushSignUp(BuildContext context) async {
    FirebaseUser _user = await Navigator.of(context).push(
          MaterialPageRoute<FirebaseUser>(
            fullscreenDialog: true,
            builder: (BuildContext context) => SignUpPage(
                  logo: logo,
                  auth: widget.auth,
                ),
          ),
        );
    Navigator.of(context).pop(_user);
  }

  @override
  build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1.5,
          center: Alignment(0.0, -0.4),
          colors: [
            Colors.white,
            Colors.purple[900],
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Hero(tag: logo.tag, child: logo.child),
          Positioned(
            bottom: 50.0,
            left: 45.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  height: 75.0,
                  minWidth: 120.0,
                  color: Theme.of(context).buttonColor,
                  onPressed: () => _pushLogin(context),
                ),
                SizedBox(
                  width: 65.0,
                ),
                MaterialButton(
                  child: Text(
                    'Sign-up',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  height: 75.0,
                  minWidth: 120.0,
                  color: Theme.of(context).buttonColor,
                  onPressed: () => _pushSignUp(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
