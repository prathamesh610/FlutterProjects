import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import './widgets/chat/messages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator()
              : MaterialApp(
                  title: 'FlutterChat',
                  theme: ThemeData(
                    primarySwatch: Colors.pink,
                    backgroundColor: Colors.pink[300],
                    accentColor: Colors.deepPurpleAccent,
                    accentColorBrightness: Brightness.dark,
                    buttonTheme: ButtonTheme.of(context).copyWith(
                      buttonColor: Colors.pink,
                      textTheme: ButtonTextTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home: StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.hasData) {
                        return ChatScreen();
                      }
                      return AuthScreen();
                    },
                  ),
                ),
    );
  }
}
