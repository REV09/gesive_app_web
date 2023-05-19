import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/pages/page_login.dart';
import 'package:gesive_web_app/src/pages/page_prueba.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        'paginaPrueba': (_) => const MyHomePage(title: "Titulo de pruebas")
      },
    );
  }
}
