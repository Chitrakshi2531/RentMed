import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
  User? user = FirebaseAuth.instance.currentUser ;
  CollectionReference equipments = FirebaseFirestore.instance.collection('equipments');
}
