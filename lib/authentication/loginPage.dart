import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:pos/assets/animatedLogo.dart';
import 'package:pos/assets/shutter.dart';

import 'loginAuthenticationButtons.dart';

class LoginPage extends StatefulWidget {
  final POSLogoHero logo;
  final BuildContext context;
  final FirebaseAuth auth;

  LoginPage({this.logo, this.context, @required this.auth});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  Size size = Size(500.0, 630.0);
  List<AuthenticationButton> buttons;

  AnimationController _cloudAnimationController;
  Animation<Offset> _cloudAnimation;

  AnimationController _materialAnimationController;
  Animation<Offset> _materialAnimation;

  AnimationController _shutterAnimationController;
  Animation<double> _leftShutter;
  Animation<double> _rightShutter;

  AnimationController _buttonAnimationController;

  @override
  void dispose() {
    _cloudAnimationController.dispose();
    _materialAnimationController.dispose();
    _shutterAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeCloudAnimation();
    initializeMaterialAnimation();
    initializeShutterAnimation();
    initializeButtonAnimation();
    buttons = LoginAuthenticationButtons(context: context, auth: widget.auth)
        .generate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            SlideTransition(
              position: _cloudAnimation,
              child: Image(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/images/purpleClouds.jpg'),
              ),
            ),
            SlideTransition(
              position: _materialAnimation,
              child: Container(
                child: Material(
                  color: Color(0xFF0300DE),
                ),
              ),
            ),
            Positioned(
              top: 165.0,
              child: Hero(
                tag: widget.logo.tag,
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: POSLogo(rotate: true),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(0.0)
                  ..rotateY(_leftShutter.value),
                child: CustomPaint(
                  size: size,
                  painter: ShutterPainter(Shutter.left()),
                ),
              ),
            ),
            Positioned(
              right: 100.0,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(1, 3, 0.001)
                  ..rotateX(0.0)
                  ..rotateY(_rightShutter.value),
                child: CustomPaint(
                  size: size,
                  painter: ShutterPainter(Shutter.right()),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: SizedBox(
                height: 300.0,
                width: 150.0,
                child: ListView.builder(
                  itemCount: buttons.length * 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index.isOdd) return SizedBox(height: 10.0);

                    final int i = index ~/ 2;

                    return SizeTransition(
                      sizeFactor: CurvedAnimation(
                          parent: _buttonAnimationController,
                          curve: Curves.easeOut),
                      child: buttons[i],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initializeButtonAnimation() {
    _buttonAnimationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
  }

  void initializeMaterialAnimation() {
    _materialAnimationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _materialAnimation = Tween<Offset>(
      begin: Offset(0.0, 2.0),
      end: Offset(0.0, 0.36),
    ).animate(CurvedAnimation(
        parent: _materialAnimationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          _buttonAnimationController.forward();
      });

    _materialAnimationController.forward();
  }

  void initializeCloudAnimation() {
    _cloudAnimationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _cloudAnimation = Tween<Offset>(
      begin: Offset(0.0, -2.0),
      end: Offset(0.0, -0.32),
    ).animate(CurvedAnimation(
        parent: _cloudAnimationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });

    _cloudAnimationController.forward();
  }

  void initializeShutterAnimation() {
    _shutterAnimationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _leftShutter = Tween<double>(begin: -2.0, end: 0.0)
        .animate(_shutterAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _rightShutter =
        Tween<double>(begin: 2.0, end: 0.0).animate(_shutterAnimationController)
          ..addListener(() {
            setState(() {});
          });

    _shutterAnimationController.forward();
  }
}
