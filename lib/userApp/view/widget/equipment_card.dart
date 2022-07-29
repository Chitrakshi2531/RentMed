import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EquipmentCard extends StatefulWidget {
  const EquipmentCard({Key? key, required this.equipment}) : super(key: key);
  final DocumentSnapshot equipment;

  @override
  State<EquipmentCard> createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {

  @override
  Widget build(BuildContext context) {
    bool _availability = widget.equipment['availability'];
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor.withOpacity(0.5),),
              child: Container(
                margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.equipment['equipmentImage'],),
                    fit: BoxFit.fill,
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                widget.equipment['equipmentName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
            Text(
              '${_availability ? 'Available' : 'Not Available'}',
              style: TextStyle(
                height: 1.5,
              ),
            ),
            Text(
              widget.equipment['rent'].toString(),
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ],
        ),
      )
    ) ;
  }
}
