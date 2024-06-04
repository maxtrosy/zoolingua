import 'package:flutter/material.dart';
import 'welcome.dart'; // Importa el archivo welcome.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crear una cuenta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateAccountScreen(),
    );
  }
}

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  DateTime? _selectedDate;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _guardianNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              child: Image.asset(
                'assets/register.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.95),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Crea una cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF20B7FF),
                    ),
                  ),
                  Text(
                    'para que empiece tu aprendizaje',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildLabeledTextField(
                    context,
                    label: 'Nombre del niñ@',
                    hintText: '',
                    icon: Icons.person,
                    controller: _nameController,
                  ),
                  SizedBox(height: 10),
                  _buildDateField(context),
                  SizedBox(height: 10),
                  _buildLabeledTextField(
                    context,
                    label: 'Nombre del tutor',
                    hintText: '',
                    icon: Icons.person_outline,
                    controller: _guardianNameController,
                  ),
                  SizedBox(height: 10),
                  _buildLabeledTextField(
                    context,
                    label: 'Usuario',
                    hintText: '',
                    icon: Icons.email,
                    controller: _emailController,
                  ),
                  SizedBox(height: 10),
                  _buildLabeledTextField(
                    context,
                    label: 'Contraseña',
                    hintText: '',
                    icon: Icons.lock,
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        _validateAndSubmit();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Color(0xFF20B7FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: Text(
                        'Crear la cuenta',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndSubmit() {
    if (_nameController.text.isEmpty ||
        _selectedDate == null ||
        _guardianNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, complete todos los campos.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()), 
      );
    }
  }

  Widget _buildLabeledTextField(BuildContext context,
      {required String label,
      required String hintText,
      required IconData icon,
      bool obscureText = false,
      TextEditingController? controller}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 1), 
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              prefixIcon: Icon(icon, color: Color(0xFF20B7FF)),
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Color(0xFF20B7FF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Color(0xFF20B7FF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fecha de nacimiento',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Color(0xFF20B7FF)),
            ),
            child: InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF20B7FF)),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  hintText: _selectedDate == null
                      ? 'Seleccionar fecha'
                      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}