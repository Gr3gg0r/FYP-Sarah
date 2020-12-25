import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp_app/root/shared/custom_appbar.dart';
import 'package:temp_app/root/shared/loading_screen.dart';
import 'package:temp_app/root/view/management/manage_profile.dart';
import 'package:temp_app/root/view/management/manage_register.dart';

class ManageView extends StatelessWidget {
  Widget _customFloating(context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ManageRegister())),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.deepPurpleAccent,
                Colors.blue,
                //Colors.blueAccent,
                Colors.lightBlueAccent
              ]),
        ),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "Assets/Image/cover.png",
        ),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        appBar: customAppBar(
            title: "Kemaskini Data Pelajar",
            color1: Colors.deepPurpleAccent,
            color2: Colors.blue,
            color3: Colors.lightBlueAccent),
        floatingActionButton: _customFloating(context),
        body: CustomListBuilder(),
      ),
    );
  }
}

class CustomListBuilder extends StatefulWidget {
  @override
  _CustomListBuilderState createState() => _CustomListBuilderState();
}

class _CustomListBuilderState extends State<CustomListBuilder> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection("UserProfile").orderBy('name').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        if (snapshot.hasError) {
          return Text("Something wrong");
        }
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot documnt) {
            return Card(
              child: ListTile(
                title: Text(documnt.data()['name']),
                subtitle: Text(documnt.data()['cardNo']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(documnt.data()['photoUrl']),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfileView(
                              snapshot: documnt,
                            ))),
                trailing: Text(documnt.data()['class'] ?? "null"),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
