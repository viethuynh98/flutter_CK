import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/app_elevated_button.dart';
import '../components/app_text_field.dart';
import '../constants.dart';
import 'package:websafe_svg/websafe_svg.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController nameController = TextEditingController();
  final String title = 'Welcome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // WebsafeSvg.asset("assets/icons/bg.svg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                const Text(
                  "Let's Play Quiz",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                ),
                AppTextField(
                  controller: nameController,
                  hintText: 'Enter Your Name',
                  action: TextInputAction.done,
                  prefixIcon: const Icon(Icons.home_max, color: Colors.grey),
                ),
                const SizedBox(height: 40.0),
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: AppElevatedButton(
                    text: "Let's start a quiz",
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
