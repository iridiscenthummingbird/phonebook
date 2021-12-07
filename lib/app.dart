import 'package:flutter/material.dart';
import 'package:phonebook/di.dart';
import 'package:phonebook/screens/main_screen/main_screen.dart';
import 'package:phonebook/screens/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DI(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Phonebook',
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/main': (context) => const MainScreen(),
        },
      ),
    );
  }
}
