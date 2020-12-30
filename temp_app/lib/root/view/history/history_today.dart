import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp_app/root/shared/loading_screen.dart';
import 'package:temp_app/root/view/management/manage_profile.dart';

class HistoryToday extends StatelessWidget {
  final String date = DateFormat('dd-MM-yyyy').format(new DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarikh : $date"),
        centerTitle: true,
      ),
      body: StudentClockIn(),
    );
  }
}

class StudentClockIn extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final start2 = new DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore.collection("ClockInHistory").where("date",isGreaterThanOrEqualTo: start2).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot snapshot) {
              var date = new DateTime.fromMicrosecondsSinceEpoch(snapshot.data()["date"].microsecondsSinceEpoch);
              String time = DateFormat().add_jm().format(date);
              return Card(child: _UserCard(snapshot,time));
            }).toList(),
          );
        });
  }
}

class _UserCard extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final String time;
  _UserCard(this.snapshot,this.time);

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
          leading:CircleAvatar(
            backgroundImage: NetworkImage(snap.data.data()["photoUrl"]),
          ),
          title: Text("${snap.data.data()["name"] ?? ""}"),
          subtitle: Text("Suhu: ${snapshot.data()["temp"]}"),
          trailing: Text("$time"),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => ProfileView(snapshot: snap.data,)
          )),
        );
      },
    );
  }
}
