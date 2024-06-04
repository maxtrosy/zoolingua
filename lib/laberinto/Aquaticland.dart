import 'package:flutter/material.dart';
import 'Sylvanthia.dart';

class Laberinto1 extends StatefulWidget {
  @override
  Lab1 createState() => Lab1();
}

class Lab1 extends State<Laberinto1> {
  var textStyle = TextStyle(
    fontSize: 70,
    fontWeight: FontWeight.bold,
    color: Color(0xff2e234f),
    fontFamily: 'TT_Bricks',
  );

  final List<List<int>> maze = [
    [1, 0, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 1, 0, 1, 0, 1],
    [1, 1, 0, 1, 0, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 1, 1],
    [1, 0, 1, 0, 1, 0, 0, 1],
    [1, 0, 1, 0, 0, 0, 1, 1],
    [1, 0, 0, 1, 1, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 0, 1],
  ];

  int ufila = 0;
  int ucolumna = 1;

  void movimiento(int nfila, int ncolumna) {
    if (nfila >= 0 &&
        nfila < maze.length &&
        ncolumna >= 0 &&
        ncolumna < maze[0].length) {
      if (maze[nfila][ncolumna] == 0) {
        setState(() {
          ufila = nfila;
          ucolumna = ncolumna;
        });
        if (nfila == 7 && ncolumna == 6) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Laberinto2()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondos/aquaticland.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140),
              Text('Aquaticland', style: textStyle),
              Spacer(flex: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: maze[0].length,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: maze.length * maze[0].length,
                itemBuilder: (context, index) {
                  int i = index ~/ maze[0].length;
                  int j = index % maze[0].length;

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 45,
                      height: 70,
                      child: Stack(
                        children: [
                          Image.asset(
                            maze[i][j] == 1
                                ? "assets/imgmatriz/tronco.png"
                                : "assets/imgmatriz/cc.png",
                          ),
                          if (ufila == i && ucolumna == j)
                            Positioned.fill(
                              child: Image.asset(
                                  "assets/personajes/pandacuatico.png"),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Spacer(flex: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff572d20),
                    child: IconButton(
                      icon: Icon(Icons.arrow_upward, color: Colors.white),
                      onPressed: () {
                        movimiento(ufila - 1, ucolumna);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Color(0xff572d20),
                    child: IconButton(
                      icon: Icon(Icons.arrow_downward, color: Colors.white),
                      onPressed: () {
                        movimiento(ufila + 1, ucolumna);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Color(0xff572d20),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        movimiento(ufila, ucolumna - 1);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Color(0xff572d20),
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        movimiento(ufila, ucolumna + 1);
                      },
                    ),
                  ),
                ],
              ),
              Spacer(flex: 20),
            ],
          ),
        ),
      ),
    );
  }
}
