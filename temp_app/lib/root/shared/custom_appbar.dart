import 'package:flutter/material.dart';

Widget customAppBar(
{Color color1,Color color2,Color color3,String title}
    ) {
  return AppBar(
    centerTitle: true,
    title: Text("$title"),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                color1,
                color2,
                //Colors.blueAccent,
                color3
              ])),
    ),
  );
}