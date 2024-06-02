import 'package:flutter/material.dart';
import 'change_password_page.dart';
import 'login_page.dart';
import '../services/local/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, this.username});

  final String title;
  final String? username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPrefs prefs = SharedPrefs();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 40.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Text(
                      'Welcome ${widget.username}',
                      style:
                          const TextStyle(color: Colors.orange, fontSize: 40.0),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => ChangePasswordPage(
                                  username: widget.username,
                                ));
                        Navigator.push(context, route);
                      },
                      child: const Text(
                        'Change password',
                        style: TextStyle(color: Colors.brown, fontSize: 16.8),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        prefs.saveKeyCheck();
                        Route route = MaterialPageRoute(
                            builder: (context) => const LoginPage());
                        Navigator.of(context).pushAndRemoveUntil(
                          route,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.brown, fontSize: 16.8),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
