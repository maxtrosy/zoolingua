import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Ajusta el tamaño según sea necesario
            
          ],
        ),
        backgroundColor: Color(0xFF20B7FF), // Esto asegura que la barra sea azul
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menú'),
              decoration: BoxDecoration(
                color: Color(0xFF20B7FF),
              ),
            ),
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                // Manejar la navegación
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                // Manejar la navegación
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Option 3'),
              onTap: () {
                // Manejar la navegación
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 180,
              height: 180,
              child: ElevatedButton(
                onPressed: () {
                  // Manejar el evento del botón
                },
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/junglelengua.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      // Manejar el evento del botón
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // Opcional: bordes redondeados
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'assets/junglelengua.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      // Manejar el evento del botón
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // Opcional: bordes redondeados
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'assets/junglelengua.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 180,
              height: 180,
              child: ElevatedButton(
                onPressed: () {
                  // Manejar el evento del botón
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // Opcional: bordes redondeados
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      'assets/junglelengua.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}