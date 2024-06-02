import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_prefs_test1/pages/home_page.dart';
import '../services/local/shared_prefs.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPrefs prefs = SharedPrefs();
  late bool isLogin;
  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() => _navigateToHome());
  }

  Future getValidationData() async {
    await prefs.getKeyCheck().then((value) {
      isLogin = value ?? false;
      print(isLogin);
      setState(() {});
    });
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      Route route = MaterialPageRoute(builder: (context) => isLogin == false ? const LoginPage() : const HomePage());
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Icons.home,
      nextScreen: const LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.scale,
    );
  }
}
