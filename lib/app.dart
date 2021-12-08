import 'package:flutter/material.dart';
import 'package:phonebook/di.dart';
import 'package:phonebook/screens/add_user_screen/add_user_screen.dart';
import 'package:phonebook/screens/delails_screen/details_screen.dart';
import 'package:phonebook/screens/main_screen/main_screen.dart';
import 'package:phonebook/screens/splash_screen/splash_screen.dart';
import 'package:phonebook/utils/details_args.dart';

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
          '/addUser': (context) => const AddUserScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == DetailsScreen.detailsRouteName) {
            final args = settings.arguments as DetailsArgs;
            return MaterialPageRoute(
              builder: (context) {
                return DetailsScreen(
                  user: args.user,
                );
              },
            );
          }
        },
      ),
    );
  }
}
