import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/model/otherInfo.dart';
import 'package:hotshot/screens/describe.dart';
import 'package:hotshot/theme_provider.dart';
import 'package:provider/provider.dart';
class MenuCard extends StatefulWidget {
  // final List<int> count ;
  // var itemc ;
  // final List<int> price ;
  //  var  sum=0;
  final DishInfo dish;
  final int freq;
  const MenuCard({Key? key, required this.dish,required this.freq}) : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      //color: Colors.blueGrey.shade200,
      elevation: 0.0,
     // shadowColor: Colors.grey,
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
                  height: 70,
                  width: 70,
                  image:
                  AssetImage('assets/images/dish1.jpg'),
                  fit: BoxFit.fitHeight,

                ),
                SizedBox(width: 20,),

                SizedBox(
                  width: 110,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text:
                        TextSpan(
                            text: widget.dish.name,
                            style:  TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 18,color: (themeProvider.isDarkMode)?Colors.white:Colors.black,)),

                      ),
                      RichText(
                        maxLines: 1,
                        text:
                        TextSpan(
                            text:
                            'Rate: ₹${widget.dish.price}\n',
                            style:  TextStyle(
                                fontWeight:
                                FontWeight.w200,fontSize: 15,color: (themeProvider.isDarkMode)?Colors.white:Colors.black,)),

                      ),
                      Row(
                        children: [
                          // IconButton(
                          //     constraints:
                          //     BoxConstraints(),
                          //     onPressed: () {},
                          //     // if(count[index]>0){
                          //     //   count[index]--;
                          //     //   itemc--;
                          //     //   sum-=price[index];
                          //     //   if(itemc==0){
                          //     //     controller!.reverse();
                          //     //   }
                          //     //   if(count[index]==0){
                          //     //     count[index]=1;
                          //     //     isadd[index]= true;
                          //     //   }
                          //     //   setState(
                          //     //         () {},
                          //     //   );
                          //     //   }
                          //     // },
                          //     icon: Icon(
                          //       Icons.remove,
                          //       size: 20,
                          //     )),
                          // Text(widget.freq.toString(),
                          //     style: TextStyle(
                          //         fontSize: 15,
                          //         fontWeight:
                          //         FontWeight.w700)),
                          // IconButton(
                          //     onPressed: () {},
                          //     //   count[index]++;
                          //     //   itemc++;
                          //     //   sum+=price[index];
                          //     //   setState(() {
                          //     //
                          //     //   });
                          //     // },
                          //     icon: Icon(
                          //       Icons.add,
                          //       size: 15,
                          //     ),
                          //     constraints:
                          //     BoxConstraints()),
                        ],
                      ),



                    ],
                  ),
                ),
              ],
            ),

            // SizedBox(
            //   width: 60,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       Text((widget.freq*(widget.dish.price!)).toString() , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
            //     ],
            //   ),
            // )
                ],

              ),

            ),


    );

  }
}