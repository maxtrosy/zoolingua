import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final bool go;
  final function;
  var textStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Color(0xff2e234f),
    fontFamily: 'TT_Bricks',
  );

  GameOverScreen({required this.go, this.function});

  @override
  Widget build(BuildContext context) {
    return go
        ? Stack(children: [
            Container(
              alignment: Alignment(0, -0.3),
              child: Text("GAME OVER", style: textStyle),
            ),
            Container(
              alignment: Alignment(0, 0),
              child: GestureDetector(
                onTap: function,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.deepPurple,
                    child: Text("Play again",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                ),
              ),
            )
          ])
        : Container();
  }
}
