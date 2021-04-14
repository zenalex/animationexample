import 'package:flutter/material.dart';

import 'titanProgress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Animation example', home: SampleAnimation());
  }
}

class SampleAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(child: TitanProgress(), height: 200, width: 200),
    ));
  }
}
