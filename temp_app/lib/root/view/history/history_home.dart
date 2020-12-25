import "package:flutter/material.dart";
import 'package:temp_app/root/shared/custom_appbar.dart';
import 'package:temp_app/root/view/history/history_all.dart';
import 'package:temp_app/root/view/history/history_today.dart';

class HistoryHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customAppBar(
          title: "Halaman Sejarah",
          color1: Colors.deepPurpleAccent,
          color2: Colors.blue,
          color3: Colors.lightBlueAccent),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              width: 0.7 * width,
              height: 0.4 * height,
              child: Image.asset("Assets/Image/history.jpg"),
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.05,
              width: width * 0.7,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HistoryToday())),
                color: Colors.blueAccent,
                child: Text("Sejarah Hari Ini",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: height * 0.05,
              width: width * 0.7,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HistoryAll())),
                color: Colors.blueAccent,
                child: Text("Sejarah Semua",style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }
}
