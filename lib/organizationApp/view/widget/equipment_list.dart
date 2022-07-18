import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_rent/organizationApp/controller/firebase_services.dart';
import 'package:med_rent/organizationApp/view/widget/equipment_card.dart';

class EquipmentList extends StatelessWidget {
  const EquipmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    User? user = FirebaseAuth.instance.currentUser ;
    return StreamBuilder<QuerySnapshot>(
        stream: _services.equipments.where("providerId", isEqualTo: user?.uid).snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong...");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return ListView(
                children: snapshot.data!.docs.map((document) {
                  return EquipmentCard(equipment: document);
                }).toList()
            );
          }
          else {
            return Container(
                child: Center(
                  child: Text('No Equipments'),
                )
            );
          }
        }
    );
  }
}