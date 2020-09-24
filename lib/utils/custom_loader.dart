import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation_rotation;
  Animation<double> animation_initialRadius_in;
  Animation<double> animation_initialRadius_out;
  final double _initialRadius = 15;

  double _radius = 0.0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    animation_rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_initialRadius_in = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_initialRadius_out = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));
    _controller.addListener(() {
      setState(() {
        if (_controller.value >= 0.75 && _controller.value <= 1.0) {
          _radius = animation_initialRadius_in.value * _initialRadius;
        } else if (_controller.value >= 0.0 && _controller.value <= 0.25) {
          _radius = animation_initialRadius_out.value * _initialRadius;
        }
      });
    });
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.stop();
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
            children: <Widget>[
              Dot(
                radius: 15,
                color: Colors.black12,
              ),
              Transform.translate(
                offset:
                Offset(_radius * cos(pi / 4), _initialRadius * sin(pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.redAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(2 * pi / 4), _radius * sin(2 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.greenAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(3 * pi / 4), _radius * sin(3 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.amberAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(4 * pi / 4), _radius * sin(4 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.blue,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(5 * pi / 4), _radius * sin(5 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.orangeAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(6 * pi / 4), _radius * sin(6 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.purpleAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(7 * pi / 4), _radius * sin(7 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.yellowAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(
                    _radius * cos(8 * pi / 4), _radius * sin(8 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.brown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}
