import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_app/root/shared/custom_appbar.dart';
import 'package:temp_app/root/shared/loading_screen.dart';
import 'package:temp_app/root/view/management/manage_profile.dart';

class HistoryAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Semua Sejarah",
          color1: Colors.deepPurpleAccent,
          color2: Colors.blue,
          color3: Colors.lightBlueAccent),
      body: ListHistory(),
    );
  }
}

class ListHistory extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection("ClockInHistory")
            .orderBy('date', descending: false)
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
              return Card(child: _UserCard(snapshot, time,dateFormat));
            }).toList(),
          );
        });
  }
}

class _UserCard extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final String time;
  final String date;
  _UserCard(this.snapshot, this.time,this.date);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection("UserProfile")
          .doc(snapshot.data()['userId'])
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Text("Waitinggg");
        }
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(snap.data.data()["photoUrl"]),
          ),
          title: Text("${snap.data.data()["name"] ?? ""}"),
          subtitle: Text("Kelas : ${snap.data.data()["class"]}"),
          trailing: Text("$date \n$time",textAlign: TextAlign.center,),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ProfileView(
                        snapshot: snap.data,
                      ))),
        );
      },
    );
  }
}
