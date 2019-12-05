import 'package:theSecretChat/constants.dart';
import 'package:flutter/material.dart';
import 'package:theSecretChat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero( //animation
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if(newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  }
                  catch (e) {
                    print(e);
                    print(e.message);
                    if (e.message == null) {
                      showSpinner = false;
                      Alert(context: context,
                          title: "YOU MISSED SOMETHING!",
                          desc: "Email and Password must to be filled!",
                          type: AlertType.error,
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white, fontSize: 20),),
                              onPressed: () => Navigator.pop(context),
                              width: 120,)]).show();
                    }
                    else {
                      Alert(context: context,
                          title: "SOMETHING IS WRONG!",
                          desc: e.message,
                          type: AlertType.error,
                          buttons: [
                            DialogButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),),
                              onPressed: () => Navigator.pop(context),
                              width: 120,)
                          ]).show();
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
