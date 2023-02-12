import 'package:flutter/material.dart';
import 'package:hotshot/constants/colors.dart';

import '../widgets/sideDrawer.dart';
import '../widgets/sideDrawerShopkeeper.dart';
class ShopkeeperOrdersScreen extends StatefulWidget {
  const ShopkeeperOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ShopkeeperOrdersScreen> createState() => _ShopkeeperOrdersScreenState();
}

class _ShopkeeperOrdersScreenState extends State<ShopkeeperOrdersScreen> {
  var items = List<String>.generate(100, (i) => 'Item $i');
  var itemsList = List<List<String>>.generate(100, (i) => ['Item $i','Item ${(i+1)}','Item ${(i+2)}']);
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
        title: const Text('Current Orders',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      drawer: NavigationDrawer(),
      body:ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
       separatorBuilder: (context, index) => const SizedBox(
           height: 10,),
        itemBuilder: (context, index) {
          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green[100],
                  border: Border.all(
                    color: blackColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text("Order ID: ${items[index]}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            ),
                            Text("Time",style: TextStyle(
                              fontSize: 20,
                            ),
                            ),
                          ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Order Items: ${itemsList[index]}',
                      style: TextStyle(fontSize: 20),
                      )

                  ),
                  Align(
                      alignment: Alignment.topRight,

                      child: TextButton(onPressed: (){}, child: Text('See More'))),
                ],
              )
              //Text("\tOrder ID: ${items[index]}"),
            ),
              itemsList[index].length > 2 ? Container(
                // alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    border: Border.all(
                      color: Colors.green.shade100,
                    ),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.green,
                        ),
                        icon: Icon(Icons.check),
                        label: Text('Accept')
                    ),
                    ElevatedButton.icon(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        icon: Icon(Icons.close),
                        label: Text('Reject')

                    ),

                  ],
                ),
              )
                  :   Container(height: 0,width: 0,),
            ],
          );
        },
      )

    );
  }
}
