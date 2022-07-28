import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:med_rent/Model/category.dart';
import 'package:med_rent/organizationApp/controller/equipment_provider.dart';
import 'package:provider/provider.dart';


class AddNewProduct extends StatefulWidget {
  const AddNewProduct({Key? key}) : super(key: key);
  static const String id = 'addnewproduct - screen';

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {



  final _formKey = GlobalKey<FormState>();
  final List<String> _categories = Category().categories;
  late String equipmentName;
  late double rent;
  late int quantity;
  String dropdownvalue = 'Category 1';
  File? _imageFile;


  @override
  Widget build(BuildContext context) {

    var _provider = Provider.of<EquipmentProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Equipment / Add"),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      icon: const Icon(Icons.save,color: Colors.white),
                      label: const Text('Save', style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          if (_imageFile != null) {
                            EasyLoading.show(status: 'Saving...');
                            _provider.uploadEquipmentImage(_imageFile!.path, equipmentName,context).then((url){
                              if(url!=null){
                                EasyLoading.dismiss();
                                _provider.saveEquipmentDataToDb(equipmentName, rent, dropdownvalue, context);

                                setState((){
                                  _formKey.currentState!.reset();
                                  dropdownvalue = 'Category 1';
                                  _imageFile = null;
                                });
                              }else{
                                _provider.alertDialog(
                                  context: context,
                                  title: 'IMAGE UPLOAD',
                                  content: 'faild to upload equipment image',
                                );
                              }
                            });
                          } else {
                            _provider.alertDialog(
                                context: context,
                                title: 'EQUIPMENT IMAGE',
                                content: 'Equipment Image not selected');
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: ListView(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    onTap: (){
                                      _provider.pickImage().then((imageFile){
                                        setState(() {
                                          _imageFile = imageFile;
                                        });
                                      });
                                    },
                                    child: SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: Card(
                                        child: Center(
                                          child: _imageFile==null?const Text('Select Image'):Image.file(_imageFile!),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty)
                                      {
                                        return 'Enter Equipment Name';
                                      }
                                      setState(() {
                                        equipmentName = value;
                                      });
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Equipment Name',
                                      labelStyle: const TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor ),),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor ,width :2,),

                                      ),
                                    )
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty)
                                      {
                                        return 'Enter Rent ';
                                      }
                                      setState(() {
                                        rent = double.parse(value);
                                      });
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Rent',
                                      labelStyle: const TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor ),),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor ,width :2,),

                                      ),
                                    )
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey ),
                                      borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Category',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 50,),
                                        DropdownButton<String>(
                                          hint: const Text('Select Category',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          value:dropdownvalue,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          onChanged: (value)=> setState(() {
                                            dropdownvalue = value!;
                                          }),
                                          items: _categories.map<DropdownMenuItem<String>>((String value){
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),


                                        )

                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty)
                                      {
                                        return 'Enter Quantitiy';
                                      }
                                      setState(() {
                                        quantity =int.parse(value);
                                      });
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Quantity',
                                      labelStyle: const TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor ),),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor ,width :2,),

                                      ),
                                    )
                                ),
                              ],
                            )
                        )
                      ],
                    )
                ),
              ),
            )

          ],
        ),
      ),
    );
  }








}