import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference resumeColRef =
      FirebaseFirestore.instance.collection('resumes');
  init() {}

  
}
