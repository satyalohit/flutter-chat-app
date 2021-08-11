import 'package:flutter/material.dart';
import 'package:sixthapp/screens/authscreen.dart';
import 'package:sixthapp/screens/chatscreen.dart';
import './widgets/Auth/Auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CHAT BOX',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: Colors.blue,
            accentColor: Colors.lightBlue,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.blue,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, usersnapshot) {
            if (usersnapshot.hasData) {
              return Chatscreen();
            }
            return Authscreen();
          },
        ));
  }
}
