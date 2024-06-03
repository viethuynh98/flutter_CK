import 'package:flutter/material.dart';
import 'package:shared_prefs_test1/services/local/shared_prefs.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  SharedPrefs prefs = SharedPrefs();
  late int score = 0;
  late int playtimes = 0;

  @override
  void initState() {
    super.initState();
    // getScore();
  }

  void getAttributes() async {
    prefs.getMaxScore().then((value) {
      score = value ?? 0;
      setState(() {});
    });
    prefs.getNumOfPlays().then((value) {
      playtimes = value ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    getAttributes();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0)
            .copyWith(top: 20.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/image1.png'),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Your Attributes",
              style: TextStyle(color: Colors.blue[400], fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No. Plays: "),
                  Text("$playtimes"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("MaxScore: "),
                  Text("$score"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
