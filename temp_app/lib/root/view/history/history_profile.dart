import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_app/root/shared/custom_appbar.dart';
import 'package:temp_app/root/shared/loading_screen.dart';

class HistoryProfile extends StatelessWidget {
  final String uid;
  HistoryProfile(this.uid);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _showMyDialog(context,snapshot) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Anda Pasti ? '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Padam sejarah pelajar ini .'),
                Text('Pilih "Pasti" untuk mengesahkan pemadaman'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: Colors.redAccent,
              child: Text('Pasti'),
              onPressed: () {
                _firestore.collection("ClockInHistory").doc(snapshot.id).delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Sejarah Pelajar",
          color1: Colors.deepPurpleAccent,
          color2: Colors.blue,
          color3: Colors.lightBlueAccent),
      body: StreamBuilder(
        stream: _firestore
            .collection("ClockInHistory")
            .where("userId", isEqualTo: uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot snapshot) {
              var date = new DateTime.fromMicrosecondsSinceEpoch(
                  snapshot.data()["date"].microsecondsSinceEpoch);
              String time = DateFormat().add_jm().format(date);
              String dateFormat = DateFormat("yyyy-MM-dd").format(date);
              return Card(
                child: ListTile(
                  title: Text("$dateFormat"),
                  trailing: Text("$time"),
                  onLongPress: () =>_showMyDialog(context,snapshot),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
