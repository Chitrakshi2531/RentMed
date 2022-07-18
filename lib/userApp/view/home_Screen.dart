import 'package:flutter/material.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    ExampleItemPager pager = ExampleItemPager();
    return Scaffold(
      body: Container(
        height: 200,
        color: Theme.of(context).primaryColor,
        child: Container(
          width: 300,
          height: 300,
          child: PaginatedSearchBar<ExampleItem>(
            maxHeight: 250,
            hintText: 'Search',
            emptyBuilder: (context){
              return const Text(
                'No Results'
              );
            },
            // paginationDelegate: EndlessPaginationDelegate(
            //   pageSize: 20,
            //   maxPages: 3,
            // ),
            onSearch: ({
              required pageIndex,
              required pageSize,
              required searchQuery,
            }) async {
              return Future.delayed(const Duration(milliseconds: 1300),(){
                if(searchQuery == 'empty'){
                  return [];
                }
                if(pageIndex == 0){
                  pager = ExampleItemPager();
                }
                return pager.nextBatch();
              });
            },

            itemBuilder: (
            context,{
              required item,
              required index,
                }){
              return Text(item.title);
            }
            ),
        ),
        ),
    );
  }
}

class ExampleItem{
  final String title;
  ExampleItem({
    required this.title,
});
}

class ExampleItemPager{
  int pageIndex = 0 ;
  final int pageSize;
  ExampleItemPager({
    this.pageSize = 20,
});
  List<ExampleItem> nextBatch(){
    List<ExampleItem> batch = [];
    for(int i = 0 ;i< pageSize; i++){
      batch.add(ExampleItem(title: 'Item ${pageIndex*pageSize+i}'));
    }
    pageIndex += 1;
    return batch;
  }
}