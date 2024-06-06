import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickx;
  final bricky;
  final brickheight;
  final brickwidth;
  final bool brickBroken;

  MyBrick(
      {this.brickheight,
      this.brickwidth,
      this.brickx,
      this.bricky,
      required this.brickBroken});

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
            alignment:
                Alignment((2 * brickx + brickwidth) / (2 - brickwidth), bricky),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickheight / 2,
                width: MediaQuery.of(context).size.width * brickwidth / 2,
                color: Colors.deepPurple,
              ),
            ),
          );
  }
}
