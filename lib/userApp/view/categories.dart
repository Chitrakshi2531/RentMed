import 'package:flutter/material.dart';
import 'package:med_rent/userApp/view/equipments.dart';

import '../../Model/category.dart';


class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  static const String id = 'category_screen';

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> _categories = Category().categories;
  Tween<Offset> _offset = Tween(begin: Offset(1,0), end: Offset(0,0));

  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: AnimatedList(
        key: _listKey,
        initialItemCount: _categories.length,
        itemBuilder: (context, index,animation){
          return SlideTransition(
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Equipment( category: _categories[index],),),);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                   child: ListTile(
                     title: Hero(
                       tag: _categories[index],
                       child: Container(
                         child: DefaultTextStyle(
                           style: TextStyle(
                             color: Theme.of(context).primaryColor,
                             fontSize: 28,
                           ),
                           child: Text(
                             _categories[index],
                           ),
                         ),
                       ),
                     ),
                   ),
                ),
              ),
            ),
            position: animation.drive(_offset),
          );
        },
      ),
    );
  }
}
