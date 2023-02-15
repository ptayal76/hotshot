import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/model/restInfo.dart';

import '../constants/colors.dart';
import '../constants/loader.dart';
import '../model/orderInfo.dart';
import '../services/DishfromDish_id.dart';
import '../services/restaurantServ.dart';

class OrderCard extends StatefulWidget {
  // final RestaurantServ restServ = RestaurantServ();

  final Order data;
  const OrderCard({Key? key, required this.data}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

List<String> names = [];

void abc(List<DishInfo?> dishes) {
  for (int i = 0; i < dishes.length; i++) {
    // print(dishes![i].name!);
    print(dishes[i]!.name!);
    names.add(dishes[i]!.name!);
  }
  // return names;
  print("hello123");
}

class _OrderCardState extends State<OrderCard> {
  List<DishInfo>? dishes;
  fetchallorder() async {
    dishes = await RestaurantServ().fetchDish(context, widget.data.items);
    abc(dishes!);
    setState(() {});
  }

  // abc() async {
  //   for (int i = 0; i < dishes!.length; i++) {
  //     print(dishes![i].name!);
  //     names.add(dishes![i].name!);
  //   }
  //   print("Hello");
  // }

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallorder();
    // abc();
    // _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    // List<int> bufferInt= widget.data.pic.map((e) => e as int).toList();
    var fav = false;
    return dishes == null
        ? Loader()
        : Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                  height: 122,
                  decoration: BoxDecoration(
                      color: Colors.green[100],
                      border: Border.all(
                        color: blackColor,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID: ${widget.data.id[0]}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${widget.data.timeOfOrder.substring(11, 16)}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            // child: Text(
                            //   'Order Items: ${DishFromDishID(context, widget.data.items)}',
                            //   style: const TextStyle(fontSize: 20),
                            //   maxLines: 1,
                            //   softWrap: false,
                            //   overflow: TextOverflow.ellipsis,
                            // )),
                            child: Text(
                              'Order Items: $names',
                              style: const TextStyle(fontSize: 20),
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ]),
                      Row(
                          // alignment: Alignment.topRight,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Builder(
                              builder: ((context) {
                                return TextButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor:
                                              Colors.green.shade100,
                                          context: context,
                                          builder: (context) {
                                            return Wrap(
                                              children: [
                                                ListTile(
                                                  leading:
                                                      const Icon(Icons.note),
                                                  title: Text(
                                                      'Order ID: ${widget.data.id}'),
                                                ),
                                                // ignore: prefer_const_constructors
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.lock_clock),
                                                  // ignore: prefer_const_constructors
                                                  title: Text(
                                                      'Time: ${widget.data.timeOfOrder}'),
                                                ),
                                                ListTile(
                                                  leading: Icon(Icons.money),
                                                  title: Text(
                                                      'Total Price: ${widget.data.total}'),
                                                ),
                                                ListTile(
                                                  isThreeLine: true,
                                                  leading: const Icon(
                                                      Icons.list_sharp),
                                                  title: const Text(
                                                      'Order Items: '),
                                                  subtitle: Text(
                                                      '${widget.data.items}'),
                                                ),

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    TextButton.icon(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: const Icon(
                                                          Icons.check),
                                                      label:
                                                          const Text('Accept'),
                                                      style:
                                                          TextButton.styleFrom(
                                                        minimumSize:
                                                            const Size(120, 0),
                                                        backgroundColor:
                                                            Colors.lightGreen,
                                                      ),
                                                    ),
                                                    TextButton.icon(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: const Icon(
                                                          Icons.close),
                                                      label:
                                                          const Text('Reject'),
                                                      style:
                                                          TextButton.styleFrom(
                                                        minimumSize:
                                                            const Size(120, 0),
                                                        backgroundColor:
                                                            Colors.red.shade400,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    child: const Text('See More'));
                              }),
                            ),
                          ]),
                      // TextButton(
                      //     onPressed: () {}, child: Text('See More'))),
                    ],
                  )
                  //Text("\tOrder ID: ${items[index]}"),
                  ),
              widget.data.items.length > 2
                  ? Container(
                      // alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        border: Border.all(
                          color: Colors.green.shade100,
                        ),
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20)),
                      ),
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  // backgroundColor: Colors.green,
                                  ),
                              icon: const Icon(Icons.check),
                              label: const Text('Accept')),
                          ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade400,
                              ),
                              icon: const Icon(Icons.close),
                              label: const Text('Reject')),
                        ],
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    ),
            ],
          );
  }
}
