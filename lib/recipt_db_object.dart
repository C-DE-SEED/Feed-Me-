import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/recipt_object.dart';

class ReciptDbObject {
  final String uid;
  final String objectName;

  ReciptDbObject({this.uid, this.objectName});

//  Club list from snapshot
  List<Recipt> _reciptListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Recipt(
          doc['id'] ?? '',
          doc['category'] ?? '',
          doc['description'] ?? '',
          doc['difficulty'] ?? '',
          doc['image1'] ?? '',
          doc['image2'] ?? '',
          doc['image3'] ?? '',
          doc['ingredients_and_amount'] ?? '',
          doc['kitchen_utensils'] ?? '',
          doc['name'] ?? '',
          doc['origin'] ?? '',
          doc['persons'] ?? '',
          doc['short_discription'] ?? '',
          doc['spices'] ?? '',
          doc['time'] ?? ''
      );
    }).toList();
  }

//  get clubs stream
  Stream<List<Recipt>> getReciptObject(String objectName) {
    CollectionReference clubCollection =
    FirebaseFirestore.instance.collection(objectName);
    return clubCollection.snapshots().map(_reciptListFromSnapshot);
  }
}
