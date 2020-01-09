import 'package:androiduas/helpers/firebasehelper.dart';
import 'package:androiduas/models/mahasiswa.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FormData extends StatefulWidget {
  final String title;
  final Mahasiswa mahasiswa;
  FormData({this.title, this.mahasiswa});
  @override
  _FormDataState createState() => _FormDataState(title);
}

class _FormDataState extends State<FormData> {
  String title;
  
  final _formKey = GlobalKey<FormState>();
  FirebaseHelper db = FirebaseHelper('android_uas');

  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController ipkController = TextEditingController();  
  // Data Mahasiswa
  String nim;
  String nama;
  int semester;
  double ipk;

  _FormDataState(this.title);
  void showToast(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    if(widget.mahasiswa != null) {
      nimController.text = widget.mahasiswa.nim;
      namaController.text = widget.mahasiswa.nama;
      semesterController.text = widget.mahasiswa.semester.toString();
      ipkController.text = widget.mahasiswa.ipk.toString();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: TextFormField(
                  controller: nimController,
                  // initialValue: widget.mahasiswa != null ? widget.mahasiswa.nim : '',
                  decoration: InputDecoration(
                    labelText: 'NIM',                  
                    hintText: 'Masukan NIM',
                    filled: true,
                    border: OutlineInputBorder()               
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'Mohon Masukan NIM';
                    }
                  },
                  onSaved: (value) => nim = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: TextFormField(
                  controller: namaController,
                  // initialValue: widget.mahasiswa != null ? widget.mahasiswa.nama : '',
                  decoration: InputDecoration(
                    labelText: 'Nama',                  
                    hintText: 'Masukan Nama',
                    filled: true,
                    border: OutlineInputBorder()               
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'Mohon Masukan Nama';
                    }
                  },                  
                  onSaved: (value) => nama = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: TextFormField(
                  controller: semesterController,
                  // initialValue: widget.mahasiswa != null ? widget.mahasiswa.semester.toString() : '',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Semester',                  
                    hintText: 'Masukan Semester',
                    filled: true,
                    border: OutlineInputBorder()               
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'Mohon Masukan Semester';
                    }
                  },                  
                  onSaved: (value) => semester = int.parse(value),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: TextFormField(
                  controller: ipkController,
                  // initialValue: widget.mahasiswa != null ? widget.mahasiswa.ipk.toString() : '',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'IPK',                  
                    hintText: 'Masukan IPK',
                    filled: true,
                    border: OutlineInputBorder()               
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'Mohon Masukan IPK';
                    }
                  },                  
                  onSaved: (value) => ipk = double.parse(value),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text('Simpan', textScaleFactor: 1.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),                        
                        onPressed: () {
                          if(_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            saveData();
                            // if(widget.mahasiswa != null) {
                            //   print('update lhur');
                            // } else {
                            //   saveData();
                            // }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: RaisedButton(
                        elevation: 1,
                        child: Text('Batal', textScaleFactor: 1.3),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveData() async {
    var sendMahasiswa = Mahasiswa(nim: nim, nama: nama, semester: semester, ipk: ipk).toJson();
    var result;
    if(widget.mahasiswa != null) {
      await db.updateDocument(sendMahasiswa, widget.mahasiswa.id);
      Navigator.pop(context);
    } else {
      result = await db.addDocument(sendMahasiswa);
      if(result.documentID.isNotEmpty) {
        nimController.text = '';
        namaController.text = '';
        semesterController.text = '';
        ipkController.text = '';
        showToast(context, 'Data Berhasil Disimpan');
      } else {
        showToast(context, 'Data Gagal Disimpan');
      }
    }

  }  
}