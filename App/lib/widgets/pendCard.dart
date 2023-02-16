import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotshot/model/otherInfo.dart';
import 'package:hotshot/screens/describe.dart';
import 'package:expandable/expandable.dart';

class PendCard extends StatefulWidget {

  @override
  State<PendCard> createState() => _PendCardState();
}

class _PendCardState extends State<PendCard> {
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
                                Text('Lohit Canteen',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),   //widget.data.restaurantName
                                Text('Lohit Hostel',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),)     //widget.data.category
                              ],
                            ),

                          ],
                        ),
                     InkWell(
                       onTap: ()
                      {
                        print("Container clicked");
                        // Navigator.pushReplacement(context,
                        //     new MaterialPageRoute(builder: (BuildContext context) => ()));

                      },
                       child: Container(
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.greenAccent),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Generated QR',style: TextStyle(fontWeight: FontWeight.w300 )),
                         ),
                       ),
                     ),
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Noodles',style: TextStyle(fontSize: 15),),                 //widget.data.dish[i].name
                              Text('3 x ₹80',style: TextStyle(fontSize: 15),)                 //item count x item price
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
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Noodles',style: TextStyle(fontSize: 15),),
                              Text('3 x ₹80',style: TextStyle(fontSize: 15),)                 //item count x item price
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
                        itemCount: 15
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
                      Text('15/02/2023 at 9:53 p.m.',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                      Text('₹1200',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))                                                     //total amount
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

