import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_rent/organizationApp/controller/firebase_services.dart';
import 'package:med_rent/equipment_details.dart';
import 'package:med_rent/userApp/view/widget/equipment_card.dart';

class EquipmentList extends StatefulWidget {
  const EquipmentList({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  State<EquipmentList> createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
        stream: _services.equipments.where("category", isEqualTo: widget.category).snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong...");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: GridView.count(
                childAspectRatio:size.width/(size.height/1.45),
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 6,
                children: snapshot.data!.docs.map((document) {
                  return Expanded(
                      child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentDetails( equipment: document,),),);
                          },
                          child: EquipmentCard(equipment: document)
                      )
                  );
                }).toList()
               ),
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
