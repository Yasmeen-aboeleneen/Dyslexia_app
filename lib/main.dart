import 'package:dyslexia_app/Core/Helper/on_generate_route_function.dart';
import 'package:dyslexia_app/Views/Splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashScreen.routeName,
      home: SplashScreen(),
      
     );
  }
}

 