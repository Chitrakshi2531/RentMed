import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../equipment_details.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  static const String id = 'search_screen';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    fillColor: Colors.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search Equipment',
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Icon(Icons.search,size: 20,color: Theme.of(context).primaryColor,),
                    ),
                  ),
                  onChanged: (val){
                    setState(() {
                      query = val;
                    });
                  }
              ),
            ),
            Container(
             height: size.height * 0.8,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('equipments').snapshots(),
                builder: (context , snapshots){
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? Center(child: CircularProgressIndicator(),)
                      : ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context,index){
                              var data = snapshots.data!.docs[index].data() as Map<String,dynamic>;
                              if (query.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    title: Text(
                                      data['equipmentName'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      data['provider']['organizationName'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                      ),
                                    ),
                                    trailing: Text(
                                      data['rent'].toString(),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentDetails( equipment: snapshots.data!.docs[index],),),);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }
                              if (data['equipmentName']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(query.toLowerCase())) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    title: Text(
                                      data['equipmentName'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    subtitle: Text(
                                      data['provider']['organizationName'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          ),
                                    ),
                                    trailing: Text(
                                      data['rent'].toString(),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EquipmentDetails( equipment: snapshots.data!.docs[index],),),);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }
                          );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}