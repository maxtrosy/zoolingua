import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}


class Character {
  final String name;
  final String imagePath;

  Character({required this.name, required this.imagePath});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZOOLINGUA',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkFirstTime();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;
    if (isFirstTime) {
      _showConfigDialog();
    } else {
      _navigateToMenu();
    }
  }

  void _showConfigDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    List<String> characterIcons = [
      'assets/icons/character1.png',
      'assets/icons/character2.png',
      'assets/icons/character3.png',
      'assets/icons/character4.png',
    ];
    String selectedIcon = characterIcons.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Configuración inicial'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Ingresa tu nombre'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: 'Ingresa tu edad'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Text('Selecciona tu personaje:'),
                SizedBox(height: 10),
                Wrap(
                  spacing: 20,
                  children: characterIcons.map((icon) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIcon = icon;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectedIcon == icon ? Colors.green : Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.asset(
                          icon,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Aquí puedes guardar la configuración inicial y cerrar el diálogo
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setBool('first_time', false);
                  prefs.setString('name', nameController.text);
                  prefs.setInt('age', int.parse(ageController.text));
                  prefs.setString('character_icon', selectedIcon);
                });
                _navigateToMenu();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToMenu() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => MenuScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            'ZOOLINGUA',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.orangeAccent,
      Colors.pinkAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.purpleAccent,
      Colors.yellowAccent,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Aquí puedes agregar la acción para mostrar el perfil
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Configuración'),
              onTap: () {
                // Aquí puedes agregar la acción para la configuración
              },
            ),
            ListTile(
              title: Text('Ayuda'),
              onTap: () {
                // Aquí puedes agregar la acción para la ayuda
              },
            ),
            ListTile(
              title: Text('Acerca de'),
              onTap: () {
                // Aquí puedes agregar la acción para acerca de
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            6,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LetterRecognitionScreen(),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SyllableCombinationScreen(),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WritingActivityScreen(),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Juego ${index + 1}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LetterRecognitionScreen extends StatelessWidget {
  const LetterRecognitionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconocimiento de letras'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 4,
          children: List.generate(
            27,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  String letter;
                  if (index < 26) {
                    letter = String.fromCharCode(index + 65);
                  } else {
                    letter = 'Ñ';
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LetterCard(letter: letter),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      index < 26
                          ? String.fromCharCode(index + 65)
                          : 'Ñ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LetterCard extends StatelessWidget {
  final String letter;

  const LetterCard({Key? key, required this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Letra $letter'),
      ),
      body: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SyllableCombinationScreen extends StatefulWidget {
  const SyllableCombinationScreen({Key? key}) : super(key: key);

  @override
  _SyllableCombinationScreenState createState() =>
      _SyllableCombinationScreenState();
}

class _SyllableCombinationScreenState extends State<SyllableCombinationScreen> {
  final List<String> syllables = [
    'ma','me', 'mi','mo','mu',
    'pa','pe','pi','po','pu',
    'sa','se','si','so','su',
    'la','le','li','lo','lu',
    'a','e','i','o','u'
  ];

  List<String> selectedSyllables = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Combinación de Sílabas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Área para las sílabas seleccionadas
          Expanded(
            flex: 5,
            child: Container(
              height: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse:
                    true, // Para mostrar las combinaciones de abajo hacia arriba
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: selectedSyllables.map((syllable) {
                        return GestureDetector(
                          onVerticalDragEnd: (details) {
                            if (details.primaryVelocity! < 0) {
                              setState(() {
                                selectedSyllables.remove(syllable);
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: MediaQuery.of(context).size.width / 5,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              syllable,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Área para seleccionar las sílabas
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.grey[200],
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                ),
                itemCount: syllables.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSyllables.add(syllables[index]);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        syllables[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WritingActivityScreen extends StatelessWidget {
  const WritingActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escritura de Letras, Sílabas y Palabras'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCategoryCard(
              context,
              title: 'Letras',
              items: ['A', 'E', 'I', 'O', 'U'],
              descriptions: [
                'Anillo',
                'Elefante',
                'Isla',
                'Oso',
                'Uva',
              ],
              icons: [
                Icons.ring_volume,
                Icons.ac_unit,
                Icons.star_half,
                Icons.ac_unit,
                Icons.access_alarm,
              ],
            ),
            SizedBox(height: 20.0),
            _buildCategoryCard(
              context,
              title: 'Sílabas',
              items: ['ma', 'me', 'mi', 'mo', 'mu'],
              descriptions: [
                'Manzana',
                'Mesa',
                'Miel',
                'Mono',
                'Mundo',
              ],
              icons: [
                Icons.bed,
                Icons.cake,
                Icons.drive_eta,
                Icons.emoji_food_beverage,
                Icons.fireplace,
              ],
            ),
            SizedBox(height: 20.0),
            _buildCategoryCard(
              context,
              title: 'Palabras',
              items: ['casa', 'perro', 'gato', 'libro', 'lápiz'],
              descriptions: [
                'Casa grande',
                'Perro blanco',
                'Gato negro',
                'Libro rojo',
                'Lápiz amarillo',
              ],
              icons: [
                Icons.house,
                Icons.pets,
                Icons.pets,
                Icons.book,
                Icons.edit,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context,
      {required String title,
      required List<String> items,
      required List<String> descriptions,
      required List<IconData> icons}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.0),
            Column(
              children: List.generate(items.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            icons[index],
                            size: 32.0,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            items[index],
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        descriptions[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: Text('Pantalla de perfil'),
      ),
    );
  }
}