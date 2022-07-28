import 'package:flutter/material.dart';
import 'package:med_rent/userApp/view/widget/equipment_list.dart';

class Equipment extends StatefulWidget {
  const Equipment({Key? key, required this.category}) : super(key: key);
  static const String id = 'equipment_screen';
  final String category;

  @override
  State<Equipment> createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children : [
              Hero(
                tag: widget.category,
                child: Container(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                    child: Text(
                      widget.category,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: EquipmentList(category: widget.category,),
                    )),
              )
            ]
          ),
        ),
      )
    );
  }
}
