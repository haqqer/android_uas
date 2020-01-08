class Mahasiswa {
  String id;
  String nim;
  String nama;
  int semester;
  double ipk;

  Mahasiswa({this.id, this.nim, this.nama, this.semester, this.ipk});

  Mahasiswa.fromMap(Map snapshot, String id) :
    id = id ?? '',
    nim = snapshot['nim'],
    nama = snapshot['nama'], 
    semester = snapshot['semester'],
    ipk = snapshot['ipk'];
  
  Map<String, dynamic> toMap() {
    Map<String, dynamic> item = Map<String, dynamic>();
    item['id'] = this.id;
    item['nim'] = this.nim;
    item['nama'] = this.nama;
    item['semester'] = this.semester;
    item['ipk'] = this.ipk;
    return item;
  }

  toJson() {
    return {
      "id": id,
      "nim": nim,
      "nama": nama,
      "semester": semester,
      "ipk": ipk,
    };
  }
}