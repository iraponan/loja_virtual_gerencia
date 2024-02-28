import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/config/firebase_options.dart';
import 'package:loja_virtual_gerencia/pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      title: 'Gerência da Loja Virtual',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        iconTheme: const IconThemeData(
          color: Colors.pinkAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    ),
  );
}
