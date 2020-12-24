import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrViewer extends StatelessWidget {
  final String docID;
  QrViewer(this.docID);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("QR CODE PELAJAR"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          child: Container(
            width: width,
            child: Center(
              child: QrImage(
                data: docID,
                version: QrVersions.auto,
                size: width*0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
