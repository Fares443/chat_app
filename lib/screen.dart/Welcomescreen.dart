// ignore: file_names
import 'package:flutter/material.dart';
import 'package:chat_app/screen.dart/register_screen.dart';

import '../widgets/my_button.dart';
import 'signin_screen.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({Key? key}) : super(key: key);
  static const String screenRoute = 'Welcomescreen';

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: 180,
                  width: double.infinity,
                  child: Image.asset('images/logo.png'),
                ),
                const Text(
                  'MessageMe',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff2e386b)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              color: Colors.yellow[900]!,
              title: 'Sign In',
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),
            MyButton(
              color: Colors.blue[800]!,
              title: ' register',
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.screenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
