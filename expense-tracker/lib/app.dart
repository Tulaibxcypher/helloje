import 'package:flutter/material.dart';
import 'package:my_first_app/app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App', // Replace with your app's title
      theme: ThemeData(
        // Customize your app's theme here
        primarySwatch: Colors.blue,
      ),
      home:  const MyAppView(), // Replace with your main screen
    );
  }
}