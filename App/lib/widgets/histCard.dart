import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotshot/model/otherInfo.dart';
import 'package:hotshot/screens/describe.dart';
import 'package:expandable/expandable.dart';

import '../constants/globvar.dart';
import '../model/dishInfo.dart';
import '../model/orderInfo.dart';

class HistCard extends StatefulWidget {
  final Order orders;
  final Map<DishInfo,int> mp;
  const HistCard({Key? key, required this.orders,required this.mp}) : super(key: key);
  @override
  State<HistCard> createState() => _HistCardState();
}

class _HistCardState extends State<HistCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.teal,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 10.0,
        shadowColor: Colors.grey,
        //shape: ShapeBorder(BorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              height: 80,
                              width: 90,
                              image:
                              AssetImage('assets/images/dish1.jpg'),                                                //widget.data.dish[1].pic
                            ),
                            SizedBox(width: 10,),
                            Column(
                            //  mainAxisAlignment: MainAxisAlignment.,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(allRest[widget.orders.restaurantId]!.restaurantName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),   //widget.data.restaurantName
                                Text(allRest[widget.orders.restaurantId]!.location,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),)     //widget.data.category
                              ],
                            ),

                          ],
                        ),

                        // Container(child: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text('Accepted',style: TextStyle(fontWeight: FontWeight.w300 )),  //(( widget.data.status== 'accepted')?'Accepted':'Rejected')
                        // ),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.greenAccent),),//(( widget.data.status== 'accepted')?Colors.greemAccent:Colors.orange)

                      ],
                    ),
                    // color: Colors.teal[800],
                  ),  //rest.name


                  Container(height: 1,color: Colors.black,),
          ExpandablePanel(
            header: Text('View All'),
            collapsed: ListView.separated(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  DishInfo key=widget.mp.keys.elementAt(index);
                  int value=widget.mp.values.elementAt(index);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(key.name!,style: TextStyle(fontSize: 15),),                 //widget.data.dish[i].name
                      Text('${value} x ₹${key.price}',style: TextStyle(fontSize: 15),)                 //item count x item price
                    ],
                  ); //(data: widget.stat[index]
                },
                shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                // physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 1,
                  );
                },
                itemCount: 1
            ),
            expanded: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  DishInfo key=widget.mp.keys.elementAt(index);
                  int value=widget.mp.values.elementAt(index);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(key.name!,style: TextStyle(fontSize: 15),),
                      Text('${value} x ₹${key.price}',style: TextStyle(fontSize: 15),)                 //item count x item price
                    ],
                  ); //(data: widget.stat[index]
                },
                shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                // physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 1,
                  );
                },
                itemCount: widget.mp.length
            ),

            //tapHeaderToExpand: true,
            //hasIcon: true,
          ),

                  // Container(height: 80,
                  // child: ),

                   Container(height: 1, color: Colors.black,),
                  Container(height: 1,color: Colors.black,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.orders.timeOfOrder.substring(0,10),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                      Text('₹${widget.orders.total.toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))                                                     //total amount
                    ],
                  ),
                  //Container(height: 1,color: Colors.black,)

              
                ],
              ),
            ),
          ]),
        ));
  }
}

