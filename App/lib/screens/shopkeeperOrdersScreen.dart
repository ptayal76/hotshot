import 'package:flutter/material.dart';
import 'package:hotshot/constants/colors.dart';
import 'package:hotshot/widgets/ShopkeeperOrderCard.dart';

import '../constants/loader.dart';
import '../model/orderInfo.dart';
import '../services/orderServ.dart';
// import '../widgets/shopkeeperOrderCard.dart';
import '../widgets/my_shopkeeper_drawer.dart';
import '../widgets/sideDrawer.dart';
import '../widgets/sideDrawerShopkeeper.dart';
import 'package:mongo_dart/mongo_dart.dart' hide State, Size, Builder;

class ShopkeeperOrdersScreen extends StatefulWidget {
  const ShopkeeperOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ShopkeeperOrdersScreen> createState() => _ShopkeeperOrdersScreenState();
}

class _ShopkeeperOrdersScreenState extends State<ShopkeeperOrdersScreen>
    with SingleTickerProviderStateMixin {
  List<Order>? order;
  final OrderServ restServ = OrderServ();
  fetchresponsependingorder() async {
    order = await restServ.fetchResponsePendingOrders(context);
    setState(() {});
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late TabController _tabController;
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchresponsependingorder();
    _tabController = TabController(vsync: this, length: 3);
  }

  var items = List<String>.generate(100, (i) => 'Item $i');
  var itemsList = List<List<String>>.generate(
      100, (i) => ['Item $i', 'Item ${(i + 1)}', 'Item ${(i + 2)}']);
  @override
  Widget build(BuildContext context) {
    fetchresponsependingorder();
    return order == null
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              // backgroundColor: greenColor,
              actions: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/droppedImage.jpg'),
                  // backgroundColor: greenColor,
                ),
              ],
              title: const Text(
                'Current Orders',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // color: Colors.black,
                ),
              ),
              centerTitle: true,
              elevation: 5,
            ),
            drawer: MyShopkeeperDrawer(),
            body: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: order!.length,
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      OrderCard(data: order![index]),
                      Container(
                        // alignment: Alignment.bottomCenter,
                        decoration: const BoxDecoration(
                            // color: Colors.green[100],
                            // border: Border.all(
                            //     // color: Colors.green.shade100,
                            //     ),
                            // borderRadius:
                            //     const BorderRadius.all(Radius.circular(20)),
                            ),
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () async {
                                  // setState(() async {
                                  await OrderServ()
                                      .AcceptOrders(context, order![index].id);
                                  setState(() {
                                    fetchresponsependingorder();
                                  });
                                  // });
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (BuildContext context) =>
                                  //             MainPage()));
                                },
                                style: ElevatedButton.styleFrom(
                                    // backgroundColor: Colors.green,
                                    ),
                                icon: const Icon(Icons.check),
                                label: const Text('Accept')),
                            ElevatedButton.icon(
                                onPressed: () async {
                                  await OrderServ()
                                      .RejectOrders(context, order![index].id);
                                  setState(() {
                                    fetchresponsependingorder();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade400,
                                ),
                                icon: const Icon(Icons.close),
                                label: const Text('Reject')),
                          ],
                        ),
                      ),
                    ],
                  );
                }));
  }
}
            // return Stack(
            //   alignment: AlignmentDirectional.bottomCenter,
            //   children: [
            //     Container(
            //         height: 122,
            //         decoration: BoxDecoration(
            //             color: Colors.green[100],
            //             border: Border.all(
            //               color: blackColor,
            //             ),
            //             borderRadius:
            //                 const BorderRadius.all(Radius.circular(20))),
            //         child: Column(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            //               child: Align(
            //                 alignment: Alignment.topCenter,
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       "Order ID: ${order![index]}",
            //                       style: const TextStyle(
            //                         fontSize: 20,
            //                       ),
            //                     ),
            //                     const Text(
            //                       "Time",
            //                       style: TextStyle(
            //                         fontSize: 20,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Row(children: [
            //               Expanded(
            //                 child: Align(
            //                     alignment: Alignment.bottomLeft,
            //                     child: Text(
            //                       'Order Items: ${itemsList[index]}',
            //                       style: const TextStyle(fontSize: 20),
            //                       maxLines: 1,
            //                       softWrap: false,
            //                       overflow: TextOverflow.ellipsis,
            //                     )),
            //               ),
            //             ]),
            //             Row(
            //                 // alignment: Alignment.topRight,
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 children: [
            //                   Builder(
            //                     builder: ((context) {
            //                       return TextButton(
            //                           onPressed: () {
            //                             showModalBottomSheet(
            //                                 backgroundColor:
            //                                     Colors.green.shade100,
            //                                 context: context,
            //                                 builder: (context) {
            //                                   return Wrap(
            //                                     children: [
            //                                       ListTile(
            //                                         leading:
            //                                             const Icon(Icons.note),
            //                                         title: Text(
            //                                             'Order ID: ${items[index]}'),
            //                                       ),
            //                                       // ignore: prefer_const_constructors
            //                                       ListTile(
            //                                         leading: const Icon(
            //                                             Icons.lock_clock),
            //                                         // ignore: prefer_const_constructors
            //                                         title:
            //                                             Text('Time: 9:05 PM'),
            //                                       ),
            //                                       const ListTile(
            //                                         leading: Icon(Icons.money),
            //                                         title: Text(
            //                                             'Total Price: Rupees 439/-'),
            //                                       ),
            //                                       ListTile(
            //                                         isThreeLine: true,
            //                                         leading: const Icon(
            //                                             Icons.list_sharp),
            //                                         title: const Text(
            //                                             'Order Items: '),
            //                                         subtitle: Text(
            //                                             '${itemsList[index]}'),
            //                                       ),

            //                                       Row(
            //                                         mainAxisAlignment:
            //                                             MainAxisAlignment
            //                                                 .spaceAround,
            //                                         children: [
            //                                           TextButton.icon(
            //                                             onPressed: () {
            //                                               Navigator.of(context)
            //                                                   .pop();
            //                                             },
            //                                             icon: const Icon(
            //                                                 Icons.check),
            //                                             label: const Text(
            //                                                 'Accept'),
            //                                             style: TextButton
            //                                                 .styleFrom(
            //                                               minimumSize:
            //                                                   const Size(
            //                                                       120, 0),
            //                                               backgroundColor:
            //                                                   Colors.lightGreen,
            //                                             ),
            //                                           ),
            //                                           TextButton.icon(
            //                                             onPressed: () {
            //                                               Navigator.of(context)
            //                                                   .pop();
            //                                             },
            //                                             icon: const Icon(
            //                                                 Icons.close),
            //                                             label: const Text(
            //                                                 'Reject'),
            //                                             style: TextButton
            //                                                 .styleFrom(
            //                                               minimumSize:
            //                                                   const Size(
            //                                                       120, 0),
            //                                               backgroundColor:
            //                                                   Colors
            //                                                       .red.shade400,
            //                                             ),
            //                                           ),
            //                                         ],
            //                                       )
            //                                     ],
            //                                   );
            //                                 });
            //                           },
            //                           child: const Text('See More'));
            //                     }),
            //                   ),
            //                 ]),
            //             // TextButton(
            //             //     onPressed: () {}, child: Text('See More'))),
            //           ],
            //         )
            //         //Text("\tOrder ID: ${items[index]}"),
            //         ),
            //     itemsList[index].length > 2
            //         ? Container(
            //             // alignment: Alignment.bottomCenter,
            //             decoration: BoxDecoration(
            //               color: Colors.green[100],
            //               border: Border.all(
            //                 color: Colors.green.shade100,
            //               ),
            //               borderRadius: const BorderRadius.vertical(
            //                   bottom: Radius.circular(20)),
            //             ),
            //             height: 25,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 ElevatedButton.icon(
            //                     onPressed: () {},
            //                     style: ElevatedButton.styleFrom(
            //                         // backgroundColor: Colors.green,
            //                         ),
            //                     icon: const Icon(Icons.check),
            //                     label: const Text('Accept')),
            //                 ElevatedButton.icon(
            //                     onPressed: () {},
            //                     style: ElevatedButton.styleFrom(
            //                       backgroundColor: Colors.red.shade400,
            //                     ),
            //                     icon: const Icon(Icons.close),
            //                     label: const Text('Reject')),
            //               ],
            //             ),
            //           )
            //         : Container(
            //             height: 0,
            //             width: 0,
            //           ),
            //   ],
            // );
          // },
//           }
        
//   }
// }