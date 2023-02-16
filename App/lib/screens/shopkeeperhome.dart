import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/constants/colors.dart';
import 'package:hotshot/constants/text.dart';
import 'package:hotshot/screens/shopkeeperOrdersScreen.dart';
import 'package:hotshot/widgets/sideDrawer.dart';

import '../widgets/sideDrawerShopkeeper.dart';

class ShopkeeperHomePage extends StatefulWidget {
  const ShopkeeperHomePage({Key? key}) : super(key: key);

  @override
  State<ShopkeeperHomePage> createState() => _ShopkeeperHomePageState();
}

class _ShopkeeperHomePageState extends State<ShopkeeperHomePage> {
  var textEditingController = TextEditingController();
  int index = 0;
  var items = List<String>.generate(100, (i) => 'Item $i');
  // print(items.length);
  // var items = <String>['One', 'Two'];
  List<bool> isSelected = [true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: greenColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/droppedImage.jpg'),
            backgroundColor: greenColor,
          ),
        ],
        title: const Text(
          'Restaurant Name',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      drawer: myNavigationDrawer(),
      backgroundColor: Colors.brown[100],
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        // shrinkWrap: true,
        children: <Widget>[
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: greenColor,
                  minimumSize: const Size(80, 50),
                ),
                onPressed: () {},
                label: const Text('Scan QR', style: TextStyle(fontSize: 20)),
                icon: const Icon(Icons.qr_code_scanner),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: blackColor,
                  disabledBorderColor: blackColor,
                  color: Colors.green[400],
                  constraints: const BoxConstraints(
                    minHeight: 50.0,
                    minWidth: 100.0,
                  ),
                  children: const <Widget>[
                    // modified_text(text: 'Open',color: blackColor,size: 20),
                    Text('Open',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Closed',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    // modified_text(text: 'Closed',color: blackColor,size: 20),

                    // Icon(Icons.ac_unit),
                    // Icon(Icons.call),
                  ],
                ),
              ),
            ],
          ),
          Row(children: const <Widget>[
            SizedBox(width: 5),
            Expanded(
                child: Divider(
              color: blackColor,
              thickness: 2,
            )),
            Expanded(
              child: Divider(
                color: blackColor,
                thickness: 2,
              ),
            ),
            SizedBox(width: 5),
          ]),
          Container(
            height: 40,
            child: Row(
              children: [
                AnimSearchBar(
                  width: 250,
                  // autoFocus: true,
                  textController: textEditingController,
                  onSuffixTap: () {},
                  onSubmitted: (p0) => "",
                ),
                // width: 20,
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Add Items')),
                ),
              ],
            ),
          ),

          // ElevatedButton.icon(
          //   style: ElevatedButton.styleFrom(
          //     // backgroundColor: greenColor,
          //     minimumSize: Size(80, 50),
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => ShopkeeperOrdersScreen()));
          //   },
          //   // label: modified_text(text: 'Current Orders',color: blackColor,size: 20),
          //   label: const Text('Current Orders',
          //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          //   icon: const Icon(Icons.food_bank),
          // ),
          const SizedBox(
            height: 1,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              // scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 225, 241, 243),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              children: const [
                                Image(
                                  image: NetworkImage(
                                      "https://tse2.mm.bing.net/th?id=OIP.Jd-H-LHiVSkNBlLR65nuVwHaEK&pid=Api&P=0"),
                                  height: 120,
                                  width: 140,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 50, left: 60),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 201, 199, 199),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 16.0),
                                          child: Text(
                                            "Dinner",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                          child: Image.asset(
                                        "assets/Veg.png",
                                        height: 20,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5, left: 12),
                                child: Text(
                                  "Mexican pizza",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 12, right: 38),
                                    child: Text(
                                      "₹ 400",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Out of stock"),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: const Text(
                              "    Edit    ",
                              style: TextStyle(fontSize: 20),
                            ),
                            icon: const Icon(
                              size: 20,
                              Icons.edit,
                              color: Color.fromARGB(255, 18, 229, 25),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: const Text(
                              "Remove",
                              style: TextStyle(fontSize: 20),
                            ),
                            icon: const Icon(
                              size: 20,
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
                // return Card(
                //   color: const Color.fromARGB(255, 225, 241, 243),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         child: Column(
                //           children: const [
                //             Image(
                //               image: NetworkImage(
                //                   "https://tse2.mm.bing.net/th?id=OIP.Jd-H-LHiVSkNBlLR65nuVwHaEK&pid=Api&P=0"),
                //               height: 120,
                //               width: 130,
                //             ),
                //           ],
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(top: 4),
                //             child: Row(
                //               children: [
                //                 Padding(
                //                   padding:
                //                       const EdgeInsets.only(right: 8, left: 8),
                //                   child: Container(
                //                     decoration: const BoxDecoration(
                //                       color: Color.fromARGB(255, 201, 199, 199),
                //                       borderRadius:
                //                           BorderRadius.all(Radius.circular(4)),
                //                     ),
                //                     child: const Padding(
                //                       padding: EdgeInsets.symmetric(
                //                           vertical: 4.0, horizontal: 16.0),
                //                       child: Text(
                //                         "Dinner",
                //                         style: TextStyle(color: Colors.white),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(right: 8.0),
                //                   child: Container(
                //                       child: Image.asset(
                //                     "assets/Veg.png",
                //                     height: 20,
                //                     width: 20,
                //                   )),
                //                 ),
                //                 SizedBox(
                //                   height: 20,
                //                   child: ElevatedButton.icon(
                //                     onPressed: () {},
                //                     label: const Text(
                //                       "Remove",
                //                       style: TextStyle(fontSize: 12),
                //                     ),
                //                     icon: const Icon(
                //                       size: 15,
                //                       Icons.close,
                //                       color: Colors.red,
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           const Padding(
                //             padding: EdgeInsets.only(top: 5, left: 12),
                //             child: Text(
                //               "Mexican pizza",
                //               style: TextStyle(
                //                   fontSize: 25, fontWeight: FontWeight.w500),
                //             ),
                //           ),
                //           Row(
                //             children: [
                //               const Padding(
                //                 padding: EdgeInsets.only(left: 12, right: 38),
                //                 child: Text(
                //                   "₹ 400",
                //                   style: TextStyle(
                //                       fontSize: 25,
                //                       fontWeight: FontWeight.w500),
                //                 ),
                //               ),
                //               ElevatedButton(
                //                 onPressed: () {},
                //                 child: const Text("Out of stock"),
                //                 style: ElevatedButton.styleFrom(
                //                     backgroundColor: Colors.red),
                //               ),
                //               // ElevatedButton(onPressed: () {

                //               // }, child: Text("Remove item"))
                //             ],
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // );
              }),
          // ListView.separated(
          //     padding: const EdgeInsets.all(8),
          //     itemCount: items.length,
          //     separatorBuilder: (context, index) => const SizedBox(
          //           height: 10,
          //         ),
          //     itemBuilder: (context, index) {
          //       return Card(
          //         color: Color.fromARGB(255, 225, 241, 243),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               child: Column(
          //                 children: [
          //                   Image(
          //                     image: NetworkImage(
          //                         "https://tse2.mm.bing.net/th?id=OIP.Jd-H-LHiVSkNBlLR65nuVwHaEK&pid=Api&P=0"),
          //                     height: 10,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 4),
          //                   child: Row(
          //                     children: [
          //                       Padding(
          //                         padding:
          //                             const EdgeInsets.only(right: 8, left: 8),
          //                         child: Container(
          //                           decoration: BoxDecoration(
          //                             color: Color.fromARGB(255, 201, 199, 199),
          //                             borderRadius:
          //                                 BorderRadius.all(Radius.circular(4)),
          //                           ),
          //                           child: Padding(
          //                             padding: const EdgeInsets.symmetric(
          //                                 vertical: 4.0, horizontal: 16.0),
          //                             child: Text(
          //                               "Dinner",
          //                               style: TextStyle(color: Colors.white),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.only(right: 8.0),
          //                         child: Container(
          //                             child: Image.asset(
          //                           "assets/Veg.png",
          //                           height: 10,
          //                         )),
          //                       ),
          //                       SizedBox(
          //                         height: 10,
          //                         child: ElevatedButton.icon(
          //                           onPressed: () {},
          //                           label: Text(
          //                             "Remove",
          //                             style: TextStyle(fontSize: 12),
          //                           ),
          //                           icon: Icon(
          //                             size: 5,
          //                             Icons.close,
          //                             color: Colors.red,
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 5, left: 10),
          //                   child: Text(
          //                     "Mexican pizza",
          //                     style: TextStyle(
          //                         fontSize: 25, fontWeight: FontWeight.w500),
          //                   ),
          //                 ),
          //                 Row(
          //                   children: [
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.only(left: 6, right: 10),
          //                       child: Text(
          //                         " 400",
          //                         style: TextStyle(
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.w500),
          //                       ),
          //                     ),
          //                     ElevatedButton(
          //                       onPressed: () {},
          //                       child: Text("Out of stock"),
          //                       style: ElevatedButton.styleFrom(
          //                           backgroundColor: Colors.red),
          //                     ),
          //                     // ElevatedButton(onPressed: () {

          //                     // }, child: Text("Remove item"))
          //                   ],
          //                 )
          //               ],
          //             )
          //           ],
          //         ),
          //       );
          //     }),
        ],
      ),
    );
  }
}
