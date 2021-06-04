import 'package:blog_app/model/categories.dart';
import 'package:flutter/material.dart';


class categories_list extends StatelessWidget {
  const categories_list({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listCategories.length,
          itemBuilder: (context, index) {
            final _data = listCategories[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${_data.title}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, ),),
                          SizedBox(width: 10,),
                          Icon(_data.icon, color: Colors.white,)
                        ], 
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
