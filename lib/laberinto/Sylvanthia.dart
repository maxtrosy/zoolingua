import 'package:flutter/material.dart';
import 'PandaFin.dart';

class Laberinto2 extends StatefulWidget {
  @override
  Lab2 createState() => Lab2();
}

class Lab2 extends State<Laberinto2> {
  var textStyle = TextStyle(
    fontSize: 70,
    fontWeight: FontWeight.bold,
    color: Colors.green, //97d728
    fontFamily: 'TT_Bricks',
  );

  final List<List<int>> maze = [
    [1, 0, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 1, 0, 1, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 1, 0, 1, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 1, 1, 1, 1, 1, 1, 0, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
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
        if (nfila == 8 && ncolumna == 9) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryPage2()),
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
            image: AssetImage('assets/fondos/sss.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 120),
            Text('Sylvanthia', style: textStyle),
            Spacer(flex: 25),
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
                              ? "assets/imgmatriz/bambo.png"
                              : "assets/imgmatriz/ccc.png",
                        ),
                        if (ufila == i && ucolumna == j)
                          Positioned.fill(
                            child: Image.asset("assets/personajes/panda.png"),
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
            Spacer(flex: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xff23b27e),
                  child: IconButton(
                    icon: Icon(Icons.arrow_upward, color: Colors.white),
                    onPressed: () {
                      movimiento(ufila - 1, ucolumna);
                    },
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xff23b27e),
                  child: IconButton(
                    icon: Icon(Icons.arrow_downward, color: Colors.white),
                    onPressed: () {
                      movimiento(ufila + 1, ucolumna);
                    },
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xff23b27e),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      movimiento(ufila, ucolumna - 1);
                    },
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xff23b27e),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      movimiento(ufila, ucolumna + 1);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
