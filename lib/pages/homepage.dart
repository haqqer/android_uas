import 'package:androiduas/pages/formdata.dart';
import 'package:androiduas/pages/listdata.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Android UAS'),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListData()));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 18.0 / 14.0,
                      child: Icon(Icons.people, size: 60),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: Center(
                        child: Text('Data Mahasiswa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                      )
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormData(title: 'Tambah Mahasiswa')));
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 18.0 / 14.0,
                      child: Icon(Icons.create, size: 60),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: Center(
                        child: Text('Tambah Mahasiswa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}