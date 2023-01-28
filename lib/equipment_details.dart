import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EquipmentDetails extends StatefulWidget {
  const EquipmentDetails({Key? key, required this.equipment}) : super(key: key);
  final DocumentSnapshot equipment;

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  @override
  Widget build(BuildContext context) {
    bool _availability = widget.equipment['availability'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),),
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
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
              padding: const EdgeInsets.only(left: 30, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      widget.equipment['equipmentName'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    '${_availability ? 'Available' : 'Not Available'}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    widget.equipment['rent'].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 10),
                    child: Text(
                      'Organization Details',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    widget.equipment['provider']['organizationName'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    widget.equipment['provider']['address'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    widget.equipment['provider']['number'].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ]
              ),
            )
          ],
        ),
      )
    );
  }
}
