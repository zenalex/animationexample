import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TitanProgress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TitanProgressAnimationState();
  }
}

class TitanProgressAnimationState extends State<TitanProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Path _path;
  double _maxWidth, _maxHeight;
  final _minWidth = 30;
  final _minHeight = 30;
  Image _car1;
  Image _car2;
  Image _car3;
  Image _car4;
  int _currentCar = 1;
  DateTime _lastPaint;
  //GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
    //_path = drawPath();
    _car1 = Image.asset(
      'lib/assets/car2red1.png',
      scale: 1.5,
    );
    _car2 = Image.asset(
      'lib/assets/car2red2.png',
      scale: 1.5,
    );
    _car3 = Image.asset(
      'lib/assets/car2red3.png',
      scale: 1.5,
    );
    _car4 = Image.asset(
      'lib/assets/car2red4.png',
      scale: 1.5,
    );
    _lastPaint = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _maxWidth = constraints.maxWidth;
        _maxHeight = constraints.maxHeight;
        return _body();
      },
    );
  }

  Widget _body() {
    return Stack(children: [
      Positioned(
        top: calculate(_animation.value).dy,
        left: calculate(_animation.value).dx,
        child: Container(
            child: Transform.rotate(
                angle: _animation.value * 2 * pi + pi, child: _getCarImage())),
      )
    ]);
  }

  Widget _getCarImage() {
    var time = DateTime.now().difference(_lastPaint).inMilliseconds;
    if (time > 500) {
      _currentCar++;
      if (_currentCar > 4) _currentCar = 1;
      _lastPaint = DateTime.now();
    }
    switch (_currentCar) {
      case 1:
        return _car1;
        break;
      case 2:
        return _car2;
        break;
      case 3:
        return _car3;
        break;
      case 4:
        return _car4;
        break;
      default:
    }
    return null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Path drawPath() {
    var width = max(_maxWidth, _minWidth);
    var height = max(_maxHeight, _minHeight);
    var maxSize = min(width, height);
    var radius = maxSize / 3;
    //Size size = Size(10, 10);
    var delta = 20;
    Path path = Path();
    var rect = Rect.fromCircle(
        center: Offset(width / 2 - delta, height / 2 - delta), radius: radius);
    //path.moveTo(0, -height / 2);
    path.addOval(rect);
    //path.quadraticBezierTo(
    //    size.width / 2, size.height, size.width, size.height / 2);
    return path;
  }

  Offset calculate(value) {
    if (_path == null) _path = drawPath();
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }
}
