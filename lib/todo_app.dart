import 'package:flutter/material.dart';
import 'package:sample_todo/screens/splash_screen_page.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter To-Do App',
      home: SplashScreen(),
    );
  }
}
