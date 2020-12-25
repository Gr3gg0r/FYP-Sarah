import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:temp_app/root/shared/loading_screen.dart';
import 'package:temp_app/root/view/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RootDir()
    );
  }
}


class RootDir extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future:Firebase.initializeApp(),
      builder: (BuildContext context, snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          return HomePage();
        }
        return LoadingScreen();
      },
    );
  }
}


