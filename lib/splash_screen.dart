import 'package:flutter/material.dart';
import 'dart:async';
import 'start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showStartScreen = false;
  bool _showLingua1 = false;
  bool _showLingua2 = false;

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showStartScreen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showStartScreen
          ? (_showLingua1
              ? _buildLingua1Screen()
              : (_showLingua2 ? _buildLingua2Screen() : _buildStartScreen()))
          : _buildSplashScreen(),
    );
  }

  Widget _buildSplashScreen() {
    return Center(
      child: Image.asset('assets/splash.png'),
    );
  }

  Widget _buildStartScreen() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/start.png', fit: BoxFit.cover),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF20B7FF),
                      padding: EdgeInsets.symmetric(vertical: 16.0), // Color azul
                    ),
                    onPressed: () {
                      setState(() {
                        _showLingua1 = true;
                      });
                    },
                    child: Text('Empieza ahora', style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF20B7FF)),
                      padding: EdgeInsets.symmetric(vertical: 16.0), // Borde azul
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Ya tengo una cuenta', style: TextStyle(color: Color(0xFF20B7FF))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLingua1Screen() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/lingua1.png', fit: BoxFit.contain),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF20B7FF), // Color azul
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  setState(() {
                    _showLingua2 = true;
                    _showLingua1 = false;
                  });
                },
                child: Text('Continuar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLingua2Screen() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/lingua2.png', fit: BoxFit.contain),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF20B7FF), // Color azul
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  setState(() {
                    _showLingua2 = true;
                    _showLingua1 = false;
                  });
                },
                child: Text('Continuar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to Home Screen!'),
      ),
    );
  }
}
