import 'package:flutter/material.dart';
// import 'package:school_tem_app/Root/View/TempCheck/QRSection/QRDataController.dart';
import 'package:qrscan/qrscan.dart' as scanner;


class QRHome extends StatefulWidget {
  @override
  _QRHomeState createState() => _QRHomeState();
}

class _QRHomeState extends State<QRHome> {

  String scanResult;

  void spawnQR() async{
    //var TscanResult = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SpawnQrScan()));
    var TscanResult = await scanner.scan();
    setState(() {
      scanResult = TscanResult;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR CONTENT"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("$scanResult"),
            SizedBox(height: 20,),
            RaisedButton( onPressed:() => spawnQR(), child: Text("Spawn QR"),)
          ],
        ),
      ),
    );
  }
}
