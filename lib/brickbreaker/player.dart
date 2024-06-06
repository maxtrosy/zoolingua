import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final playerx;
  final playerwidth;

  MyPlayer({this.playerx, this.playerwidth});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment:
            Alignment((2 * playerx + playerwidth) / (2 - playerwidth), 0.9),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 10,
            width: MediaQuery.of(context).size.width * playerwidth / 2,
            color: Colors.deepPurple,
          ),
        ));
  }
}
