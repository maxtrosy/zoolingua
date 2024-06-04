import 'package:flutter/material.dart';
import 'Aquaticland.dart';

class Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          LaberintoSelected(),
          HistoryPage1(),
        ],
      ),
    );
  }
}

class LaberintoSelected extends StatelessWidget {
  var height, width;

  List iconos = [
    "assets/iconosJuegos/mar.png",
    "assets/iconosJuegos/escalera.png",
    "assets/iconosJuegos/desierto.png",
    "assets/iconosJuegos/tundra.png"
  ];

  List titles = ["Aquaticland", "Sylvanthia", "Duna", "Frostland"];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    var textStyle = TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.bold,
        color: Color(0xff2e234f),
        fontFamily: 'TT_Bricks');
    return Scaffold(
        body: Container(
      color: Color(0xffd0edf9),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(),
              height: height * 0.25,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text('MazeZOO', style: textStyle)
                  ])),
          Container(
            decoration: BoxDecoration(
                color: Color(0xff7099d3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
            height: height * 0.75,
            width: width,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: iconos.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {},
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 6)
                            ]),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(iconos[index], width: 130),
                              Text(titles[index],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "TT_Bricks",
                                      color: Colors.black)),
                            ])));
              },
            ),
          )
        ],
      ),
    ));
  }
}

class HistoryPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondos/flota.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset("assets/dialogos/PageH1.png"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Laberinto1()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xff1f9500),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text("¡Suena divertido!",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
