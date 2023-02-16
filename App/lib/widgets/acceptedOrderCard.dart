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

class AcceptedOrderCard extends StatefulWidget {
  // final RestaurantServ restServ = RestaurantServ();

  final Order data;
  const AcceptedOrderCard({Key? key, required this.data}) : super(key: key);

  @override
  State<AcceptedOrderCard> createState() => _AcceptedOrderCardState();
}

List<String> abc(List<DishInfo?> dishes) {
  List<String> names = [];

  for (int i = 0; i < dishes.length; i++) {
    // print(dishes![i].name!);
    print(dishes[i]!.name!);
    names.add(dishes[i]!.name!);
  }
  return names;
  print("hello123");
}

class _AcceptedOrderCardState extends State<AcceptedOrderCard> {
  List<DishInfo>? dishes;
  fetchallorder() async {
    dishes = await RestaurantServ().fetchDish(context, widget.data.items);
    if (dishes != null) {
      abc(dishes!);
    }
    setState(() {});
  }

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
        ? const Loader()
        : Container(
            height: 114,
            decoration: BoxDecoration(
                // color: Colors.green[100],
                border: Border.all(
                  color: blackColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
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
                          "Order ID: ${widget.data.id.substring(0, 3)}...${widget.data.id.substring(widget.data.id.length - 3, widget.data.id.length)}",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Time: ${widget.data.timeOfOrder.substring(11, 16)}",
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
                        // ignore: unnecessary_null_comparison
                        child: abc(dishes!) != null
                            ? Text(
                                'Order Items: ${abc(dishes!)}'
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 20),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container(
                                height: 0,
                                width: 0,
                              )),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // alignment: Alignment.bottomRight,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //   OutlinedButton(
                    //       style: OutlinedButton.styleFrom(
                    //         backgroundColor: _hasBeenPressed
                    //             ? Colors.green.shade100
                    //             : Colors.grey,
                    //         //foregroundColor: _hasBeenPressed ? Colors.green : Colors.grey,
                    //       ),
                    //       onPressed: () => {
                    //             setState(() {
                    //               _hasBeenPressed = !_hasBeenPressed;
                    //               _hasBeenPressed
                    //                   ? (status = 'Order is Ready!')
                    //                   : status = 'Ready?';
                    //             })
                    //           },
                    //       child: Text(status)),
                    Builder(
                      builder: ((context) {
                        return TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                // backgroundColor: Colors.green.shade100,
                                context: context,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                            Icons.pending_actions_sharp),
                                        title: Text(
                                          'Order is not yet delivered',
                                          style: TextStyle(
                                              color: Colors.red.shade300),
                                        ),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.note),
                                        title:
                                            Text('Order ID: ${widget.data.id}'),
                                      ),
                                      // ignore: prefer_const_constructors
                                      ListTile(
                                        leading: const Icon(Icons.lock_clock),
                                        // ignore: prefer_const_constructors
                                        title: Text(
                                            'Time: ${widget.data.timeOfOrder.substring(11, 16)}'),
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.money),
                                        title: Text(
                                            'Total Price: ${widget.data.total}'),
                                      ),
                                      Flexible(
                                        child: ListTile(
                                          isThreeLine: true,
                                          leading: const Icon(Icons.list_sharp),
                                          title: const Text('Order Items: '),
                                          subtitle: Text(
                                            '${abc(dishes!)}'
                                                .replaceAll('[', '')
                                                .replaceAll(']', ''),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text('See More'),
                          // style: TextButton.styleFrom(
                          //   maximumSize: const Size(10, 10),
                          // ),
                        );
                      }),
                    ),
                  ],
                ),
                // TextButton(
                //     onPressed: () {}, child: Text('See More'))),
              ],
            )
            //Text("\tOrder ID: ${items[index]}"),
            );
  }
}
