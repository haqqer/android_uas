import 'package:androiduas/helpers/firebasehelper.dart';
import 'package:androiduas/models/mahasiswa.dart';
import 'package:androiduas/pages/formdata.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget {
  final Mahasiswa mahasiswa;
  ViewData({this.mahasiswa});
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  FirebaseHelper db = FirebaseHelper('android_uas');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahasiswa'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 75,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('NIM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(': ${widget.mahasiswa.nim}', style: TextStyle(fontSize: 16.0)),
                        ),                      
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('Nama', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(': ${widget.mahasiswa.nama}', style: TextStyle(fontSize: 16.0)),
                        ),                      
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),                    
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('Semester', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(': ${widget.mahasiswa.semester}', style: TextStyle(fontSize: 16.0)),
                        ),                      
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),                    
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('IPK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(': ${widget.mahasiswa.ipk}', style: TextStyle(fontSize: 16.0)),
                        ),                      
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white70,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FormData(title: 'Edit Mahasiswa', mahasiswa: widget.mahasiswa)));
                          },
                          child: Text('Edit'),
                        ),
                        RaisedButton(
                          color: Colors.red,
                          onPressed: () {
                            deleteData(widget.mahasiswa.id);
                            Navigator.pop(context);
                          },
                          child: Text('Hapus', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  void deleteData(String id) async {
    await db.deleteDocument(id);
  }
}