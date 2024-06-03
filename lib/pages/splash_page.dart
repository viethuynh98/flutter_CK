import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../services/local/shared_prefs.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPrefs prefs = SharedPrefs();
  bool isLogin = false;
  bool firstTime = false;
  bool isCheck = false;
  @override
  void initState() {
    // getValidationData();
    super.initState();
  }

  Future getValidationData() async {
    if (!isCheck) {
      isCheck = true;
      await prefs.getKeyCheck().then((value) {
        isLogin = value ?? false;
        setState(() {});
      });
      await prefs.getKeyCheckFirstLogin().then((value) {
        firstTime = value ?? false;
        setState(() {});
      });
    } else {
      isCheck = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    getValidationData();
    return AnimatedSplashScreen(
      backgroundColor: const Color(0xFF3b5999).withOpacity(0.6),
      splash: const CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('assets/images/logo.png'),
      ),
      nextScreen: firstTime
          ? const OnboardingScreen()
          : (isLogin == false ? const LoginPage() : const HomePage()),
      duration: 1500,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
