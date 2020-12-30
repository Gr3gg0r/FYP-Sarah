import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrCodeHome extends StatefulWidget {
  final String temp;
  QrCodeHome(this.temp);
  @override
  _QrCodeHomeState createState() => _QrCodeHomeState();
}

class _QrCodeHomeState extends State<QrCodeHome> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String success = "";
  bool permis = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateScanResult();
  }

  void updateScanResult() async {
    if (await Permission.camera.request().isGranted) {
      var result = await scanner.scan();
      var docID = _firestore.collection("ClockInHistory").doc().id;
      _firestore.collection("ClockInHistory").doc(docID).set({
        'userId': result,
        'temp': widget.temp,
        'date': DateTime.now(),
      }).then((value) {
        setState(() {
          success = "Selesai Daftar !";
          permis = true;
        });
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
        });
      });
    } else {
      setState(() {
        success = "Sila Beri Kebenaran";
      });
      Future.delayed(const Duration(seconds: 3),(){
        print("execure");
        return updateScanResult();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              width: width,
              height: 0.5 * height,
              child: permis? 
              Image.asset("Assets/Image/success.jpg"):
              Image.asset("Assets/Image/error.jpg")
              ,
            ),
            SizedBox(height: height * 0.01),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: permis? Colors.blue:Colors.red,
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 2)]),
              height: height * 0.1,
              width: width * 0.8,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "$success",
                    style:
                        TextStyle(fontSize: height * 0.03, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
