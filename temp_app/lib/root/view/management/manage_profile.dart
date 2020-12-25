
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp_app/root/view/history/history_profile.dart';
import 'package:temp_app/root/view/management/manage_edit.dart';
import 'package:temp_app/root/view/management/manage_qr.dart';
class ProfileView extends StatelessWidget {

  DocumentSnapshot snapshot;
  ProfileView({this.snapshot});

  Widget _customNameCard({name,details,width,height}){
    return Card(
      child: ListTile(
        title: Text(details??""),
        subtitle: Text(name??""),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Pelajar"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete,color: Colors.white,),
            onPressed: () => FirebaseFirestore.instance.collection("UserProfile").doc(snapshot.data()['docID']).delete().then((value) => Navigator.pop(context)),
          ),
          IconButton(
              icon: Icon(Icons.edit,color: Colors.white,),
              onPressed:()=>Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => ManageEdit(snapshot: snapshot,)
              ))
          )
        ],
      ),
      body: Center(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: Colors.black12, spreadRadius: 1,)
                    ],
                  ),
                  child: CircleAvatar(
                    minRadius: 50,
                    maxRadius: 100,
                    backgroundColor: Colors.lightBlueAccent,
                    backgroundImage: NetworkImage(snapshot.data()['photoUrl']),
                  ),
                ),
              ),

              _customNameCard(
                name: snapshot.data()['name'],
                details: "Nama Pelajar",
              ),
              _customNameCard(
                name: snapshot.data()['cardNo'],
                details: "No Kad Pelajar",
              ),
              _customNameCard(
                name: snapshot.data()['phone'],
                details: "No Kad Pelajar",
              ),
              _customNameCard(
                name: snapshot.data()['class'],
                details: "Kelas Pelajar",
              ),
              Container(
                width: width*0.8,
                child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  child: Text("Sejarah Pelajar",style: TextStyle(
                      color: Colors.white
                  ),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => HistoryProfile(snapshot.data()['docID'])
                  )),
                ),
              ),
              Container(
                width: width*0.8,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("Tunjuk QR CODE",style: TextStyle(
                      color: Colors.white
                  ),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => QrViewer(snapshot.data()['docID'])
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
