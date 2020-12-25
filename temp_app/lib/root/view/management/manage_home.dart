import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:temp_app/root/view/management/manage_register.dart';
import 'package:temp_app/root/view/management/manage_view.dart';

class ManageHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Pengurusan Pelajar"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(0),
                width: width*0.8,
                height: 0.4*height,
                child:Image.asset("Assets/Image/dashboard.png"),
              ),
              SizedBox(height: height*0.01),
              Container(
                height: height*0.05,
                width: width * 0.7,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () =>Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => ManageRegister()
                  )),
                  color: Colors.lightBlueAccent,
                  child: Text("Pendaftaran Pelajar Baru",style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: height*0.01),
              Container(
                height: height*0.05,
                width: width * 0.7,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () =>Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => ManageView()
                  )),
                  color: Colors.lightBlueAccent,
                  child: Text("Kemaskini Data Pelajar",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
