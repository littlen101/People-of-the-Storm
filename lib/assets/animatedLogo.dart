import 'package:flutter/material.dart';
import 'dart:math' show pi;

class _AnimatedUpDownPOSLogo extends AnimatedWidget {
  const _AnimatedUpDownPOSLogo({
    Key key,
    Animation<double> upDownAnimation,
  }) : super(key: key, listenable: upDownAnimation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment(
        0.0,
        animation.value,
      ),
      child: Image.asset(
        'assets/images/logo_standard.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

class _AnimatedRotatingPOSLogo extends AnimatedWidget {
  const _AnimatedRotatingPOSLogo({
    Key key,
    Animation<double> rotatingAnimation,
  }) : super(key: key, listenable: rotatingAnimation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Transform.rotate(
      angle: animation.value,
      child: Image.asset(
        'assets/images/logo_standard.png',
        fit: BoxFit.fill,
      ),
    );
  }
}

class POSLogo extends StatefulWidget {
  // Can't be both
  final bool upDown;
  final bool rotate;
  final double begin;
  final double end;

  const POSLogo({
    Key key,
    this.upDown = false,
    this.rotate = false,
    this.begin,
    this.end,
  }) : super(key: key);

  @override
  _POSLogoState createState() => _POSLogoState();
}

class _POSLogoState extends State<POSLogo> with TickerProviderStateMixin {
  Animation<double> _upDownAnimation;
  Animation<double> _rotateAnimation;
  AnimationController _upDownController;
  AnimationController _rotateAnimationController;

  @override
  void initState() {
    super.initState();
    if (widget.upDown) {
      double begin = widget.begin ?? -0.4;
      double end = widget.end ?? -0.6;
      _upDownController = AnimationController(
        duration: Duration(milliseconds: 2000),
        vsync: this,
      );
      _upDownAnimation =
          Tween<double>(begin: begin, end: end).animate(_upDownController)
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                _upDownController.reverse();
              } else if (status == AnimationStatus.dismissed) {
                _upDownController.forward();
              }
            });
      _upDownController.forward();
    }

    if (widget.rotate) {
      double begin = widget.begin ?? 0.0;
      double end = widget.end ?? (4 * pi);
      _rotateAnimationController = AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      );
      _rotateAnimation = Tween<double>(begin: begin, end: end)
          .animate(_rotateAnimationController);
      _rotateAnimationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.upDown)
      return _AnimatedUpDownPOSLogo(upDownAnimation: _upDownAnimation);
    if (widget.rotate)
      return _AnimatedRotatingPOSLogo(rotatingAnimation: _rotateAnimation);

    return null;
  }

  @override
  void dispose() {
    _rotateAnimationController?.dispose();
    _upDownController?.dispose();
    super.dispose();
  }
}

class POSLogoHero extends StatelessWidget {
  final Widget child;
  final tag;

  const POSLogoHero({this.child, this.tag});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
