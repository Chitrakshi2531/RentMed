import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_rent/organizationApp/controller/firebase_services.dart';

class EquipmentCard extends StatefulWidget {
  const EquipmentCard({Key? key, required this.equipment}) : super(key: key);
  final DocumentSnapshot equipment;

  @override
  State<EquipmentCard> createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool value = widget.equipment['availability'];
    FirebaseServices _services = FirebaseServices();
    return Padding(
      padding: const EdgeInsets.only(top: 8,right: 8,left: 8),
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: size.width * 0.05,
              ),
              child: SizedBox(
                width: size.width * 0.3,
                child: Image.network(widget.equipment['equipmentImage']),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize:  MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                        widget.equipment['equipmentName'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.create_rounded,color: Colors.white),
                                iconSize: 25,
                                onPressed: (){},
                              ),
                              IconButton(
                                icon: Icon(Icons.delete,color: Colors.white),
                                iconSize: 25,
                                onPressed: (){
                                  _services.equipments.doc(widget.equipment['equipmentID']).delete();
                                },
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Rent : ',
                        textAlign:TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          ),
                      ),
                      SizedBox(width: 2,),
                      Text(
                        widget.equipment['rent'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Availability',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,),
                      ),
                      SizedBox(width: 2,),
                      Switch.adaptive(
                          activeColor: Colors.white,
                          value: value,
                          onChanged: (value) {
                            _services.equipments.doc(widget.equipment['equipmentID']).update({'availability':value});
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
