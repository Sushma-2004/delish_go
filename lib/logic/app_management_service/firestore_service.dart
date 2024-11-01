import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference productsColRef =
      FirebaseFirestore.instance.collection('products');
  init() {}

  
}
