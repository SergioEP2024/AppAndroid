// ignore_for_file: use_super_parameters, library_private_types_in_public_api, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppV1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        '/scan': (context) => const ScanPage(), // Ruta para la página 'scan'
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 184, 221),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Container(
                width: 300,
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Logo.webp'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      border: InputBorder.none, // Elimina el borde del TextFormField
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: InputBorder.none, // Elimina el borde del TextFormField
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 200,
                height: 50, // Ancho del botón
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/scan'); // Navegar a la página 'scan'
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blueGrey, // Color de fondo del botón
                  ),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 15, color: Colors.white), // Estilo del texto del botón
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String _scanResult = 'Esperando escaneo...';

  Future<void> _scan() async {
    String scanResult;

    try {
      final result = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancelar", true, ScanMode.BARCODE);
      if (!mounted) return;
      scanResult = result;
    } catch (e) {
      scanResult = 'Error al escanear: $e';
    }

    setState(() {
      _scanResult = scanResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 184, 221),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _scan,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  backgroundColor: Colors.blueGrey, // Color de fondo del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes redondeados
                  ),
                ),
                child: const Text(
                  'Escanear',
                  style: TextStyle(fontSize: 20, color: Colors.white), // Estilo del texto del botón
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _scanResult,
                style: const TextStyle(fontSize: 18, color: Colors.white), // Estilo del texto del resultado del escaneo
              ),
            ],
          ),
        ),
      ),
    );
  }
}