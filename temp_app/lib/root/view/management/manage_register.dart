import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temp_app/root/shared/custom_appbar.dart';

class ManageRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "Assets/Image/cover.png",
        ),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: customAppBar(
            title: "Pendaftaran Pelajar Baru",
            color1: Colors.deepPurpleAccent,
            color2: Colors.blue,
            color3: Colors.lightBlueAccent),
        body: Center(
          child: CustomForm(
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  final width, height;
  CustomForm({this.width, this.height});
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  File _image;
  bool loading = false;

  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  String username, user_card, user_phone, stu_class;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future getImageFrom(selection, context) async {
    PickedFile pickedFile;
    if (selection) {
      if (await Permission.camera.request().isGranted) {
        pickedFile = await picker.getImage(source: ImageSource.camera);
      }
    } else {
      if (await Permission.storage.request().isGranted) {
        pickedFile = await picker.getImage(source: ImageSource.gallery);
      }
    }
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose from'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RaisedButton(
                  color: Colors.deepPurpleAccent,
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => getImageFrom(true, context),
                ),
                Text(
                  "OR",
                  textAlign: TextAlign.center,
                ),
                RaisedButton(
                  color: Colors.deepPurpleAccent,
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => getImageFrom(false, context),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> uploadTask(uid) async {
    final uploadTask = _storage.ref("Image/UserProfile/$uid");
    await uploadTask.putFile(_image);
    String downloadUrl = await uploadTask.getDownloadURL();
    return downloadUrl;
  }

  void CheckData() {
    if (_formKey.currentState.validate()) {
      addData();
    }
  }

  void addData() async {
    String docID = _firestore.collection("UserProfile").doc().id;
    setState(() {
      loading = true;
    });
    try {
      String downloadUrl = await uploadTask(docID);
      _firestore.collection("UserProfile").doc(docID).set({
        "name": username,
        "phone": user_phone,
        "cardNo": user_card,
        "docID": docID,
        "photoUrl": downloadUrl,
        "class": stu_class
      }).then((value) => Navigator.pop(context));
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: widget.height * 0.03),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              minRadius: 50,
              maxRadius: 100,
              backgroundColor: Colors.lightBlueAccent,
              backgroundImage: _image != null ? FileImage(_image) : null,
              child: Center(
                child: IconButton(
                  icon: _image != null
                      ? Container()
                      : Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 30,
                        ),
                  onPressed: _image == null ? _showMyDialog : () {},
                ),
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.03),
          Container(
            height: widget.height * 0.06,
            width: 0.8 * widget.width,
            color: Colors.white,
            child: TextFormField(
              onChanged: (val) => username = val,
              validator: (val) {
                if (val.isEmpty) {
                  return "Sila isikan nama pelajar";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.purpleAccent, width: 5.0),
                ),
                labelText: "Nama Pelajar",
                prefixIcon: Icon(Icons.person),
                hoverColor: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.01),
          Container(
            height: widget.height * 0.07,
            width: 0.8 * widget.width,
            color: Colors.white,
            child: TextFormField(
              validator: (val) {
                if (val.isEmpty) {
                  return "Sila isikan nombor pelajar";
                }
                return null;
              },
              onChanged: (val) => user_card = val,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.purpleAccent, width: 5.0),
                ),
                labelText: "No Kad Pelajar",
                prefixIcon: Icon(Icons.assignment),
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.01),
          Container(
            height: widget.height * 0.06,
            width: 0.8 * widget.width,
            color: Colors.white,
            child: TextFormField(
              validator: (val) {
                if (val.isEmpty) {
                  return "Sila isikan nombor talefon pelajar";
                }
                return null;
              },
              onChanged: (val) => user_phone = val,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.purpleAccent, width: 5.0),
                ),
                labelText: "No Talefon",
                prefixIcon: Icon(Icons.call),
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.01),
          Container(
            height: widget.height * 0.06,
            width: 0.8 * widget.width,
            color: Colors.white,
            child: TextFormField(
              validator: (val) {
                if (val.isEmpty) {
                  return "Sila isikan kelas pelajar";
                }
                return null;
              },
              onChanged: (val) => stu_class = val,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.purpleAccent, width: 5.0),
                ),
                labelText: "Kelas",
                prefixIcon: Icon(Icons.school),
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.03),
          Container(
            height: widget.height * 0.05,
            width: 0.5 * widget.width,
            child: !loading
                ? RaisedButton(
                    color: Colors.deepPurpleAccent,
                    child: Text(
                      "Daftar",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: CheckData,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        ],
      ),
    );
  }
}
