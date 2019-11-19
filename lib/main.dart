import 'package:flutter/material.dart';
import 'package:theSecretChat/screens/welcome_screen.dart';
import 'package:theSecretChat/screens/login_screen.dart';
import 'package:theSecretChat/screens/registration_screen.dart';
import 'package:theSecretChat/screens/chat_screen.dart';

void main() => runApp(TheSecretChat());

class TheSecretChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),*/
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen(),

      },
    );
  }
}
