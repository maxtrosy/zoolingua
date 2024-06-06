import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  var textStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Color(0xff2e234f),
    fontFamily: 'TT_Bricks',
  );

  CoverScreen({required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Stack(children: [
            Container(
                alignment: Alignment(0, -0.2),
                child: Text(
                  "Brick Breaker",
                  style: textStyle,
                )),
            Container(
              alignment: Alignment(0, -0.1),
              child: Text("Tap to play",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple[400],
                      fontFamily: "TT_Bricks")),
            )
          ]);
  }
}
