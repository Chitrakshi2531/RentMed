import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_rent/userApp/view/widget/equipment_card.dart';

import '../../../../organizationApp/controller/firebase_services.dart';
import '../../equipment_details.dart';

class RecommendedList extends StatefulWidget {
  const RecommendedList({Key? key}) : super(key: key);

  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
        stream: _services.equipments.limit(10).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong...");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((document) {
                  return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentDetails( equipment: document,),),);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: EquipmentCard(equipment: document),
                      )
                  );
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
