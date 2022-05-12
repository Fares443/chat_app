import 'package:chat_app/screen.dart/Welcomescreen.dart';
import 'package:chat_app/screen.dart/register_screen.dart';
import 'package:chat_app/screen.dart/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen.dart/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _auth.currentUser != null
          ? ChatScreen.screenRoute
          : Welcomescreen.screenRoute,
      routes: {
        ChatScreen.screenRoute: (context) => const ChatScreen(),
        Welcomescreen.screenRoute: (context) => const Welcomescreen(),
        SignInScreen.screenRoute: (context) => const SignInScreen(),
        RegisterScreen.screenRoute: (context) => const RegisterScreen(),
      },
    );
  }
}
//55