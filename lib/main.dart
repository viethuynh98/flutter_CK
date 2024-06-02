import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_prefs_test1/pages/home_page.dart';
import 'package:shared_prefs_test1/pages/quiz/add_question.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.yellow, fontSize: 20.0),
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
