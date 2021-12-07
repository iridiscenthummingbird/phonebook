import 'package:flutter/material.dart';
import 'package:phonebook/screens/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Phonebook',
      home: SplashScreen(),
    );
  }
}
