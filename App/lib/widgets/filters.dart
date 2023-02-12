import 'package:flutter/material.dart';
class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}
class Filters extends StatefulWidget {
   Filters({Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  List filtername = ['Open Now','Rating 4+','Veg','Non-Veg'];
  List filterselected = [false,false,false,false];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListView.separated(
          itemCount: filtername.length,
          padding: EdgeInsets.only(left: 16),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context,index){
            return SizedBox(
              width: 16,
            );
          },
          itemBuilder: (context,index){
            return GestureDetector(
              child: Container(
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: 100,
                decoration: BoxDecoration(
                    color: (filterselected[index])?const Color(0xff307A59):Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)
                ),
                child:  Center(
                  child: Text(
                    filtername[index],
                    style: TextStyle(
                      color: (filterselected[index])?Colors.white:Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              onTap: (){
                setState(() {
                  filterselected[index]=!filterselected[index];
                  if(index==2 || index==3){
                    if(filterselected[index]==true){
                      filterselected[5-index]=false;
                    }
                  }
                });
              },
            );
          },
      ),

    );
  }
}
