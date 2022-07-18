import 'package:flutter/material.dart';
import 'package:med_rent/organizationApp/view/new_equipment_screen.dart';
import 'package:med_rent/organizationApp/view/widget/equipment_list.dart';


class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  _EquipmentScreenState createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Equipments"),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Expanded(child: EquipmentList()),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          bottom: 60,
        ),
        child: FloatingActionButton(
            elevation: 0.0,
            child: const Icon(
                Icons.add,
                color: Colors.cyan,
                size: 40,
            ),
            backgroundColor: Colors.white,
            onPressed: (){
              Navigator.pushNamed(context, AddNewProduct.id);
            }
        ),
      ),
    );
  }
}