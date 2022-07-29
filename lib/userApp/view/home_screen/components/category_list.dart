import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../Model/category.dart';
import '../../equipments.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<String> _categories = Category().categories;
  List _icons = Category().icons;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Equipment( category: _categories[index],),),);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 60,
              width:70,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                ),
              child: Center(
                  child: FaIcon(
                    _icons[index],
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                 ),
              ),
            ),
          )
        );
      },
    );
  }
}
