import 'package:flutter/material.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/widgets/menuCard.dart';
import 'package:hotshot/widgets/cartCard.dart';
import 'package:hotshot/services/listdishesTomap.dart';
// import 'package:hotshot/model/checkInfo.dart';
import 'package:lottie/lottie.dart';

import '../constants/loader.dart';
import '../model/orderInfo.dart';
import '../services/orderServ.dart';
import '../services/restaurantServ.dart';
// import 'package:hotshot/model/checkHelper.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  List<Order>? Orders;

  // List<Map<DishInfo, int>> fetchedDishes = [];
  final OrderServ orderServ = OrderServ();
  List<Map<DishInfo, int>> fetchedDishes = [];
  // late Future<List<Map<DishInfo, int>>> datafuture;
  Future<List<Map<DishInfo, int>>> fetchusercart() async {
    // print(dishes.length);
    List<Map<DishInfo, int>> fetchedDisheslocal = [];
    List<Map<String, int>> dishes = [];

    Orders = await orderServ.fetchUserCart(context);
    print(Orders!.length);
    print('0000');
    for (int i = 0; i < Orders!.length; i++) {
      print("hereee");

      dishes.add(convert().listToMap(Orders![i].items));
      print(dishes.length);
    }

    for (int i = 0; i < dishes.length; i++) {
      List<String> dishIdsOrder = [];
      print("keeyyyy11111111");
      for (String key in dishes[i].keys.toList()) {
        print(key);
        print("keyyyyysssss");
        dishIdsOrder.add(key);
      }
      List<DishInfo> x =
          await RestaurantServ().fetchDish(context, dishIdsOrder);
      Map<DishInfo, int> mp = {};
      for (int j = 0; j < x.length; j++) {
        mp[x[j]] = dishes[i][x[j].id]!;
      }
      fetchedDisheslocal.add(mp);
    }
    setState(() {
        fetchedDishes=fetchedDisheslocal;
    });
    return fetchedDishes;
    // fetchDishesCart();

  }

  // Future<List<DishInfo>> fetchDishesCart(List<String> items) async {
  //   // for(int i=0;i<Orders!.length;i++){
  //     List<DishInfo>x=await RestaurantServ().fetchDish(context, items);
  //     return x;
  //   // }
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchusercart();
    // _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    // fetchusercart();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: const Color.fromARGB(255, 239, 102, 105),
        centerTitle: true,
      ),
    //   floatingActionButton: FloatingActionButton(
    //     child: Icon(Icons.refresh),
    //     onPressed: () async =>
    //     {
    //       await fetchusercart(),
    //       // setState(() {}),
    // }
    //   ),
      body: RefreshIndicator(
        onRefresh: fetchusercart,
        child: Column(
            children: [
          SizedBox(
              height: 40,
              child: Center(
                  child: Text(
                'Your Orders',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ))),
              // (fetchedDishes==null)?Lottie.asset('assets/lottie/empty.json', height: 200, width: 200):
              Lottie.asset('assets/lottie/cart.json', height: 200, width: 200),
         (Orders==null)?Loader():Container(
           height: MediaQuery.of(context).size.height*(0.52),
           child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, index) {

                      print(Orders!.length);
                      // print(Orders![2]);
                      return CartCard(
                        orders: Orders![index],
                        mp: fetchedDishes![index],
                      ); //(data: widget.stat[index]
                    },
                    shrinkWrap: true,
                    //scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 1,
                      );
                    },
                    itemCount: (fetchedDishes==null)?0:fetchedDishes!.length,
                  ),
         )
                // FutureBuilder(
                //   future: fetchusercart(),
                //   builder: (context,snapshot){
                //     switch (snapshot.connectionState){
                //       case ConnectionState.none:
                //         {return Text('none');}
                //       case ConnectionState.active:
                //         return Text('active');
                //       case ConnectionState.waiting:
                //         return Text('waiting');
                //       case ConnectionState.done:
                //         if (snapshot.hasData) {
                //           // build your widget tree that displays the fetched data here
                //           ListView.separated(
                //             padding: EdgeInsets.symmetric(horizontal: 2),
                //             itemBuilder: (context, index) {
                //               print(Orders!.length);
                //               print(Orders![2]);
                //               return CartCard(
                //                 orders: Orders![index],
                //                 mp: snapshot.data![index],
                //               ); //(data: widget.stat[index]
                //             },
                //             shrinkWrap: true,
                //             //scrollDirection: Axis.vertical,
                //             physics: BouncingScrollPhysics(),
                //             separatorBuilder: (context, index) {
                //               return SizedBox(
                //                 height: 1,
                //               );
                //             },
                //             itemCount: snapshot.data!.length,
                //           );
                //         } else if (snapshot.hasError) {
                //           // handle the error here
                //           Text("error");
                //         }
                //         return Loader();
                //     }
                //
                //   },
                //   // child: ListView.separated(
                //   //     padding: EdgeInsets.symmetric(horizontal: 2),
                //   //     itemBuilder: (context, index) {
                //   //       print(Orders!.length);
                //   //       print(Orders![2]);
                //   //       return CartCard(
                //   //         orders: Orders![index],
                //   //         mp: fetchedDishes[index],
                //   //       ); //(data: widget.stat[index]
                //   //     },
                //   //     shrinkWrap: true,
                //   //     //scrollDirection: Axis.vertical,
                //   //     physics: BouncingScrollPhysics(),
                //   //     separatorBuilder: (context, index) {
                //   //       return SizedBox(
                //   //         height: 1,
                //   //       );
                //   //     },
                //   //     itemCount: fetchedDishes!.length,
                //   //   ),
                // ),

        ]),
      ),
    );
  }
}
