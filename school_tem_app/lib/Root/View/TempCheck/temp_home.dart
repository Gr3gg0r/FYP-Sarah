import 'dart:ui';

import 'package:flutter/material.dart';

class TempHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Fungsi Pemeriksaan Suhu"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width * 0.8,
              child: Image.asset("Assets/Image/construct.png"),
            ),
            Text("UNDER CONSTRUCTION",style: TextStyle(
              fontSize: 0.00009*height*width,
              fontWeight: FontWeight.bold,
            ),textAlign: TextAlign.center,),
            SizedBox(height: height*0.03,),
            Text("Bahagian ini akan mula dibangunkan setelah Sarah selesai"
                " menyiapkan bahagian adruino. Ini kerana bahagian ini memerlukan "
                "sambungan adruino melalui siaran bluetooth",textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
