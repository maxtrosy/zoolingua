// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:brickbreaker/ball.dart';
import 'package:brickbreaker/brick.dart';
import 'package:brickbreaker/gameoverscreen.dart';
import 'package:brickbreaker/player.dart';
import 'package:brickbreaker/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  BrickBreaker createState() => BrickBreaker();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class BrickBreaker extends State<HomePage> {
  double bx = 0;
  double by = 0;
  double bxx = 0.01;
  double byy = 0.01;
  var byd = direction.DOWN;
  var bxd = direction.LEFT;

  bool hasGameStarted = false;
  bool go = false;

  double playerx = -0.2;
  double playerwidth = 0.4;

  static double brickwidth = 0.2;
  static double brickheight = 0.05;
  static double gap = 0.01;
  static int filas = 8;
  static int columnas = 10;
  static double wallgap =
      0.5 * (2 - columnas * brickwidth - (columnas - 1) * gap);

  List<List<dynamic>> MyBricks = [];

  @override
  void initState() {
    super.initState();
    crearBricks();
  }

  void crearBricks() {
    MyBricks.clear();
    for (int row = 0; row < filas; row++) {
      for (int col = 0; col < columnas; col++) {
        double brickx = -1 + col * (brickwidth + gap);
        double bricky = -0.9 + row * (brickheight + gap);
        MyBricks.add([brickx, bricky, 0]);
      }
    }
  }

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      updateDirection();
      moveBall();
      if (gameOver()) {
        timer.cancel();
        go = true;
      }
      checkForBrokenBricks();
    });
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < MyBricks.length; i++) {
      if (bx >= MyBricks[i][0] &&
          bx <= MyBricks[i][0] + brickwidth &&
          by <= MyBricks[i][1] + brickheight &&
          MyBricks[i][2] == 0) {
        setState(() {
          MyBricks[i][2] = 1;

          double Ldist = (MyBricks[i][0] - bx).abs();
          double Rdist = (MyBricks[i][0] + brickwidth - bx).abs();
          double Tdist = (MyBricks[i][1] - by).abs();
          double Ddist = (MyBricks[i][1] + brickheight - by).abs();

          String min = findMin(Ldist, Rdist, Tdist, Ddist);

          switch (min) {
            case "left":
              bxd = direction.LEFT;
              break;
            case "right":
              bxd = direction.RIGHT;
              break;
            case "down":
              byd = direction.DOWN;
              break;
            case "up":
              byd = direction.UP;
              break;
            default:
          }
        });
      }
    }
  }

  String findMin(double a, double b, double c, double d) {
    List<double> myList = [a, b, c, d];
    double currentMin = a;
    String min = "left";

    if (b < currentMin) {
      currentMin = b;
      min = "right";
    }
    if (c < currentMin) {
      currentMin = c;
      min = "up";
    }
    if (d < currentMin) {
      currentMin = d;
      min = "down";
    }

    return min;
  }

  bool gameOver() {
    return by >= 1;
  }

  void moveBall() {
    if (bxd == direction.LEFT) {
      bx -= bxx;
    } else if (bxd == direction.RIGHT) {
      bx += bxx;
    }
    if (byd == direction.DOWN) {
      by += byy;
    } else if (byd == direction.UP) {
      by -= byy;
    }
  }

  void updateDirection() {
    setState(() {
      if (by >= 0.9 && bx >= playerx && bx <= playerx + playerwidth) {
        byd = direction.UP;
      } else if (by <= -1) {
        byd = direction.DOWN;
      }
      if (bx >= 1) {
        bxd = direction.LEFT;
      } else if (bx <= -1) {
        bxd = direction.RIGHT;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerx - 0.2 < -1)) {
        playerx -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerx + playerwidth >= 1)) {
        playerx += 0.2;
      }
    });
  }

  void resetGame() {
    setState(() {
      playerx = -0.2;
      bx = 0;
      by = 0;
      go = false;
      hasGameStarted = false;
      crearBricks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                // tap to play
                CoverScreen(
                  hasGameStarted: hasGameStarted,
                ),
                GameOverScreen(
                  go: go,
                  function: resetGame,
                ),
                // ball
                MyBall(
                  bx: bx,
                  by: by,
                ),
                // player
                MyPlayer(
                  playerx: playerx,
                  playerwidth: playerwidth,
                ),
                // bricks
                for (var brick in MyBricks)
                  MyBrick(
                    brickheight: brickheight,
                    brickwidth: brickwidth,
                    brickx: brick[0],
                    bricky: brick[1],
                    brickBroken: brick[2] == 1,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
