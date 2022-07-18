import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class EquipmentProvider with ChangeNotifier{
  File? _imageFile;
  User? user = FirebaseAuth.instance.currentUser ;
  CollectionReference _org = FirebaseFirestore.instance.collection('organizations');
  late String equipmentUrl;
  Future<File?> pickImage() async{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 20);
    if(pickedFile != null){
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
    else {
      print('no image selected');
      notifyListeners();
    }
    return _imageFile;

  }

  Future<void> saveEquipmentDataToDb(
      equipmentName,
      rent,
      category,
      context
      ) async {
    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    CollectionReference _products = FirebaseFirestore.instance.collection('equipments');
    DocumentSnapshot _result = await _org.doc(user?.uid).get();

    try{
      await _products.doc(timeStamp.toString()).set({
        'provider' : {'organizationName': _result['organizationName'] , 'number': _result['contactNumber'], 'address': _result['address'] },
        'providerId': user?.uid,
        'equipmentName' : equipmentName,
        'rent' : rent ,
        'category' : category,
        'equipmentID': timeStamp.toString(),
        'equipmentImage': equipmentUrl,
        'availability': true

      });
      alertDialog(
          context: context,
          title: 'SAVE DATA',
          content: 'equipment details saved successfully'
      );
    }catch(e){
      alertDialog(
          context: context,
          title: 'SAVE DATA',
          content: 'e.toString()'
      );
    }
    return;
  }



  Future<String> uploadEquipmentImage(filePath,equipmentName,context) async{
    File file = File(filePath);
    var timeStamp  = Timestamp.now().millisecondsSinceEpoch;
    FirebaseStorage _storage = FirebaseStorage.instance;
    DocumentSnapshot _result = await _org.doc(user?.uid).get();
    String name = _result['organizationName'];

    try{
      await _storage.ref('equipmentImage/$name/$equipmentName$timeStamp').putFile(file);

    }on FirebaseException catch(e){
      alertDialog( context: context,
          title: 'STORAGE ERROR',
          content: e.toString());}
    String downloadURL = await _storage.ref('equipmentImage/$name/$equipmentName$timeStamp').getDownloadURL();
    equipmentUrl = downloadURL;
    notifyListeners();
    return downloadURL;
  }


  alertDialog({context,title,content}) {
    showCupertinoDialog(context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(child: const Text('OK'),
              onPressed: () => Navigator.pop(context))
        ],
      );
    });
  }




}