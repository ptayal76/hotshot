import 'package:flutter/material.dart';
import 'package:hotshot/constants/colors.dart';

import '../widgets/sideDrawer.dart';
import '../widgets/sideDrawerShopkeeper.dart';

class StationeryShopkeeperOrdersScreen extends StatefulWidget {
  const StationeryShopkeeperOrdersScreen({Key? key}) : super(key: key);

  @override
  State<StationeryShopkeeperOrdersScreen> createState() =>
      _StationeryShopkeeperOrdersScreenState();
}

class _StationeryShopkeeperOrdersScreenState
    extends State<StationeryShopkeeperOrdersScreen> {
  var items = List<String>.generate(100, (i) => 'Item $i');
  var itemsList = List<List<String>>.generate(
      100, (i) => ['Item $i', 'Item ${(i + 1)}', 'Item ${(i + 2)}']);
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
            'Current Orders',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 5,
        ),
        drawer: MyNavigationDrawer(),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                    height: 152,
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
                                  "Order ID: ${items[index]}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const Text(
                                  "Time",
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
                                child: Text(
                                  'Print Type: ${itemsList[index]}\nQuantity: ${index + 1}',
                                  style: const TextStyle(fontSize: 20),
                                  maxLines: 2,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                )),
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
                                                        'Order ID: ${items[index]}'),
                                                  ),
                                                  // ignore: prefer_const_constructors
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.lock_clock),
                                                    // ignore: prefer_const_constructors
                                                    title:
                                                        Text('Time: 9:05 PM'),
                                                  ),
                                                  const ListTile(
                                                    leading: Icon(Icons.money),
                                                    title: Text(
                                                        'Total Price: Rupees 439/-'),
                                                  ),
                                                  ListTile(
                                                    isThreeLine: true,
                                                    leading: const Icon(
                                                        Icons.list_sharp),
                                                    title: Text(
                                                        'Print Type: ${itemsList[index]}'),
                                                    subtitle: Text(
                                                        'Quantity: ${index + 1}'),
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
                                                        label: const Text(
                                                            'Accept'),
                                                        style: TextButton
                                                            .styleFrom(
                                                          minimumSize:
                                                              const Size(
                                                                  120, 0),
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
                                                        label: const Text(
                                                            'Reject'),
                                                        style: TextButton
                                                            .styleFrom(
                                                          minimumSize:
                                                              const Size(
                                                                  120, 0),
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade400,
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
                itemsList[index].length > 2
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
          },
        ));
  }
}
