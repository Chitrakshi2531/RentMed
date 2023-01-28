import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
    bool value = widget.equipment['availability'];

    FirebaseServices _services = FirebaseServices();
    return Padding(
      padding: const EdgeInsets.only(top: 8,right: 8,left: 8),
      child: SizedBox(
        width: 110,
        height: 130,
        child: Card(
          elevation: 5,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 2,
                  right: 10,
                ),
                child: Container(
                  width: 110,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor.withOpacity(0.5),),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(widget.equipment['equipmentImage'],),
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
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
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        ),
                        Row(
                            children: [
                              // IconButton(
                              //   icon: Icon(Icons.create_rounded,color: Theme.of(context).primaryColor.withOpacity(0.7),),
                              //   iconSize: 25,
                              //   onPressed: (){},
                              // ),
                              IconButton(
                                icon: Icon(Icons.delete,color: Theme.of(context).primaryColor.withOpacity(0.7),),
                                iconSize: 25,
                                onPressed: (){
                                  FirebaseStorage.instance.ref(widget.equipment['equipmentImage']).delete();
                                  _services.equipments.doc(widget.equipment['equipmentID']).delete();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted Successfully')));
                                },
                              ),
                            ]
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Rent : ',
                          textAlign:TextAlign.start,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            ),
                        ),
                        SizedBox(width: 2,),
                        Text(
                          widget.equipment['rent'].toString(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Availability',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,),
                        ),
                        SizedBox(width: 2,),
                        Switch.adaptive(
                            activeColor: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
