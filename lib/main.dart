import 'package:flutter/material.dart';
import 'pages/Welcome_page.dart';
import 'pages/change_password_page.dart';
import 'pages/login_page.dart';
import 'pages/quiz/quiz_page.dart';
import 'pages/register_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const QuizPage(),
    );
  }
}
