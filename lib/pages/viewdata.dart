import 'package:androiduas/helpers/firebasehelper.dart';
import 'package:androiduas/models/mahasiswa.dart';
import 'package:androiduas/pages/formdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget {
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  FirebaseHelper db = FirebaseHelper('android_uas');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: db.streamData(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return LinearProgressIndicator();
            return _buildList(context, snapshot.data.documents);
          },
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList()
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final mahasiswa = Mahasiswa.fromMap(snapshot.data, snapshot.documentID);
    return ListTile(
      onTap: () {
        print(mahasiswa.toMap());
        Navigator.push(context, MaterialPageRoute(builder: (context) => FormData(title: 'Edit Mahasiswa', mahasiswa: mahasiswa)));
      },
      leading: Icon(
        Icons.people,
        size: 30,
      ),
      title: Text(mahasiswa.nama),
      subtitle: Text(mahasiswa.nim),
      trailing: GestureDetector(
        onTap: () {
          deleteData(mahasiswa.id);
        },
        child: Icon(Icons.delete),
      ),
    );
  }
  void deleteData(String id) async {
    await db.deleteDocument(id);
  }
}