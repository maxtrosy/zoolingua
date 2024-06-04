import 'package:flutter/material.dart';
import 'RenoFin.dart';

class Laberinto4 extends StatefulWidget {
  @override
  Lab4 createState() => Lab4();
}

class Lab4 extends State<Laberinto4> {
  var textStyle = TextStyle(
    fontSize: 70,
    fontWeight: FontWeight.bold,
    color: Color(0xffcbeff7),
    fontFamily: 'TT_Bricks',
  );

  final List<List<int>> maze = [
    [1, 0, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 1, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 1, 1, 1, 0, 1, 1, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 0, 1],
    [1, 1, 1, 0, 1, 1, 1, 1, 0, 1],
    [1, 0, 1, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 1, 1, 1, 1, 0, 1, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 1, 0, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 0, 1],
    [1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 1, 1, 0, 0, 0, 1, 0, 1],
    [1, 0, 1, 1, 1, 1, 1, 1, 1, 1],
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
        if (nfila == 11 && ncolumna == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryPage4()),
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
            image: AssetImage('assets/fondos/tundra1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 120),
            Text('Frostland', style: textStyle),
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
                              ? "assets/imgmatriz/hielo.png"
                              : "assets/imgmatriz/cc.png",
                        ),
                        if (ufila == i && ucolumna == j)
                          Positioned.fill(
                            child:
                                Image.asset("assets/personajes/renonieve.png"),
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
                  backgroundColor: Color(0xffcbeff7),
                  child: IconButton(
                    icon: Icon(Icons.arrow_upward, color: Color(0xff5a5d60)),
                    onPressed: () {
                      movimiento(ufila - 1, ucolumna);
                    },
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xffcbeff7),
                  child: IconButton(
                    icon: Icon(Icons.arrow_downward, color: Color(0xff5a5d60)),
                    onPressed: () {
                      movimiento(ufila + 1, ucolumna);
                    },
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xffcbeff7),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xff5a5d60)),
                    onPressed: () {
                      movimiento(ufila, ucolumna - 1);
                    },
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xffcbeff7),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward, color: Color(0xff5a5d60)),
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
