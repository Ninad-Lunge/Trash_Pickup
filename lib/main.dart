import 'package:flutter/material.dart';
import 'package:trashpickup/pages/register.dart';
import 'package:trashpickup/pages/login.dart';
import 'package:trashpickup/pages/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrashPickup',
      initialRoute: '/',
      routes: {
        '/': (context) => Start(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
      },
    );
  }
}
