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
  bool isGet = false;

  @override
  void initState() {
    super.initState();
    // getScore();
  }

  void getAttributes() async {
    if (!isGet) {
      isGet = true;
      prefs.getMaxScore().then((value) {
        score = value ?? 0;
        setState(() {});
      });
      prefs.getNumOfPlays().then((value) {
        playtimes = value ?? 0;
        setState(() {});
      });
    } else {
      isGet = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    getAttributes();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 300.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/quiz_bg_1.png"),
                      fit: BoxFit.fill),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 90.0, left: 20.0),
                  color: const Color(0xFF3b5999).withOpacity(0.6),
                ),
              )),
          Padding(
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
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 15.0,
                          spreadRadius: 6.0,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Text(
                        "Your Attributes",
                        style:
                            TextStyle(color: Colors.blue[400], fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        alignment: Alignment.center,
                        height: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25.0)),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0.0, 3.0),
                                color: Colors.black26,
                                blurRadius: 6.0,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("No. Plays: "),
                              Text("$playtimes"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        alignment: Alignment.center,
                        height: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25.0)),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0.0, 3.0),
                                color: Colors.black26,
                                blurRadius: 6.0,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("MaxScore: "),
                              Text("$score"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
