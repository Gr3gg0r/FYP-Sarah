import 'package:flutter/material.dart';
import 'package:temp_app/root/view/bluetooth_connection/scan_page.dart';
import 'package:temp_app/root/view/bluetooth_connection/temp_device.dart';
import 'package:temp_app/root/view/history/history_home.dart';
import 'package:temp_app/root/view/management/manage_home.dart';
import 'package:temp_app/root/view/bluetooth_connection//qrcode/qr_code_home.dart';

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
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HistoryHome())),
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
                      builder: (BuildContext context) => QrCodeHome("36.1")),
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
