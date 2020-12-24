import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_tem_app/Root/View/ManageView/manage_home.dart';
import 'package:school_tem_app/Root/View/TempCheck/QRScanner.dart';
import 'package:school_tem_app/Root/View/TempCheck/QRSection/HomeQR.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman Utama"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              width: 0.7 * width,
              height: 0.4 * height,
              child: Image.asset("Assets/Image/temperature.png"),
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
                        builder: (BuildContext context) => ManageHome())),
                color: Colors.greenAccent,
                child: Text("Pengurusan Pelajar"),
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
                onPressed: () => {},
                color: Colors.greenAccent,
                child: Text("Sejarah Kemasukan"),
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
                    builder: (BuildContext context) => QRHome()
                  ),
                ),
                color: Colors.greenAccent,
                child: Text("Fungsi Pemeriksaan Suhu"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
