import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  final Firestore _db = Firestore.instance;
  String path;
  CollectionReference ref;

  FirebaseHelper(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getData() {
    return ref.getDocuments();
  }
  Stream<QuerySnapshot> streamData() {
    return ref.snapshots() ;
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
  Future<void> deleteDocument(String id) {
    return ref.document(id).delete();
  }
}