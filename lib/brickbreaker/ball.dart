import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final bx;
  final by;

  MyBall({this.bx, this.by});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(bx, by),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: Color(0xff2e234f),
            shape: BoxShape.circle,
          ),
        ));
  }
}
