import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotshot/model/otherInfo.dart';
import 'package:hotshot/screens/describe.dart';
class MenuCard extends StatefulWidget {
  // final List<int> count ;
  // var itemc ;
  // final List<int> price ;
  //  var  sum=0;
  //const ({Key? key, required this.count , required this.itemc , required this.price , required this.sum}) : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.blueGrey.shade200,
      elevation: 5.0,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                Image(
                  height: 80,
                  width: 100,
                  image:
                  AssetImage('assets/images/dish1.jpg'),
                ),
                SizedBox(width: 20,),

                SizedBox(
                  width: 170,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text:
                        TextSpan(
                            text: 'Hakka Noodles\n',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20)),

                      ),
                      RichText(
                        maxLines: 1,
                        text:
                        TextSpan(
                            text:
                            'Rate: ₹80\n',
                            style: const TextStyle(
                                fontWeight:
                                FontWeight.w200,color: Colors.black,fontSize: 10)),

                      ),
                      Row(
                        children: [
                          IconButton(
                              constraints:
                              BoxConstraints(),
                              onPressed: () {},
                              // if(count[index]>0){
                              //   count[index]--;
                              //   itemc--;
                              //   sum-=price[index];
                              //   if(itemc==0){
                              //     controller!.reverse();
                              //   }
                              //   if(count[index]==0){
                              //     count[index]=1;
                              //     isadd[index]= true;
                              //   }
                              //   setState(
                              //         () {},
                              //   );
                              //   }
                              // },
                              icon: Icon(
                                Icons.remove,
                                size: 20,
                              )),
                          Text("3",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                  FontWeight.w700)),
                          IconButton(
                              onPressed: () {},
                              //   count[index]++;
                              //   itemc++;
                              //   sum+=price[index];
                              //   setState(() {
                              //
                              //   });
                              // },
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                              constraints:
                              BoxConstraints()),
                        ],
                      ),



                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('₹1240' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              ),
            )
                ],

              ),

            ),


    );

  }
}