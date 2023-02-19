import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:hotshot/model/otherInfo.dart';
import 'package:hotshot/screens/checkout.dart';
import 'package:hotshot/screens/describe.dart';
import 'package:expandable/expandable.dart';
import 'package:hotshot/services/DishfromDish_id.dart';

import '../constants/globvar.dart';
import '../constants/loader.dart';
import '../model/dishInfo.dart';
import '../model/orderInfo.dart';
import '../model/restInfo.dart';

class CartCard extends StatefulWidget {
  final Order orders;
  final Map<DishInfo,int> mp;
  const CartCard({Key? key, required this.orders,required this.mp}) : super(key: key);
  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  RestInfo? rest;
  fetchrest() async{
    RestInfo restlocal=await restServ.fetchRestaurantsbyID(context, widget.orders.restaurantId);
    setState(() {
      rest=restlocal;
    });
  }
  @override
  Widget build(BuildContext context) {
    fetchrest();
    return (rest==null)?Loader():Card(
        color: const Color.fromARGB(255, 255, 140, 140),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 10.0,
        // shadowColor: Colors.grey,
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
                            // Image(
                            //   height: 80,
                            //   width: 90,
                            //   image:
                            //   AssetImage('assets/images/dish1.jpg'),                                                //widget.data.dish[1].pic
                            // ),
                            // SizedBox(width: 10,),
                            Column(
                              //  mainAxisAlignment: MainAxisAlignment.,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(rest!.restaurantName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),   //widget.data.restaurantName
                                Text(rest!.location,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),)     //widget.data.category
                              ],
                            ),

                          ],
                        ),

                        new GestureDetector(
                          onTap: ()
                          {
                            print("Container clicked");
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (BuildContext context) => checkout(order: widget.orders,name: rest!.restaurantName)));

                          },
                          //behavior: ,
                          child: Container(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Checkout',style: TextStyle(fontWeight: FontWeight.w300 )),  //(( widget.data.status== 'accepted')?'Accepted':'Rejected')
                          ),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.pink),),//(( widget.data.status== 'accepted')?Colors.greemAccent:Colors.orange)
                        )
                      ],
                    ),
                    // color: const Color.fromARGB(255, 239, 102, 105),
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
                          // var keys=widget.mp.keys.toList();
                          // var values =widget.mp.values.toList();
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
                        itemCount: widget.mp.length,
                    ),

                    //tapHeaderToExpand: true,
                    //hasIcon: true,
                  ),

                  // Container(height: 80,
                  // child: ),

                  Container(height: 1, color: Colors.black,),
                  Container(height: 1,color: Colors.black,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Text('15/02/2023 at 9:53 p.m.',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
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

