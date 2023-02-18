import 'package:flutter/material.dart';
import 'package:hotshot/widgets/histCard.dart';

import '../constants/loader.dart';
import '../model/dishInfo.dart';
import '../model/orderInfo.dart';
import '../services/listdishesTomap.dart';
import '../services/orderServ.dart';
import '../services/restaurantServ.dart';
// import 'package:hotshot/model/checkInfo.dart';
// import 'package:hotshot/model/checkHelper.dart';

class OrdHistory extends StatefulWidget {
  const OrdHistory({Key? key}) : super(key: key);

  @override
  State<OrdHistory> createState() => _OrdHistoryState();
}

class _OrdHistoryState extends State<OrdHistory> {
  // final List<int> count = [1, 1, 1, 1, 1];
  // var itemc = 0;
  // final List<int> price = [100, 200, 300, 400, 500];
  // var sum = 0;
  List<Order>? Orders;
  List<Map<String, int>> dishes = [];
  List<Map<DishInfo, int>> fetchedDishes = [];
  final OrderServ orderServ = OrderServ();
  fetchorderhistory() async {
    // print(dishes.length);
    Orders = await orderServ.fetchCompletedOrders(context);
    Orders?.addAll(await orderServ.fetchRejectedOrders(context));
    print(Orders!.length);
    print('0000');
    for (int i = 0; i < Orders!.length; i++) {
      // print("hereee");

      dishes.add(convert().listToMap(Orders![i].items));
      // print(dishes.length);
    }

    for (int i = 0; i < dishes.length; i++) {
      List<String> dishIdsOrder = [];
      // print("keeyyyy11111111");
      for (String key in dishes[i].keys.toList()) {
        // print(key);
        // print("keyyyyysssss");
        dishIdsOrder.add(key);
      }
      List<DishInfo> x =
      await RestaurantServ().fetchDish(context, dishIdsOrder);
      Map<DishInfo, int> mp = {};
      for (int j = 0; j < x.length; j++) {
        mp[x[j]] = dishes[i][x[j].id]!;
      }
      fetchedDishes.add(mp);
    }
    // fetchDishesCart();
    setState(() {});
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchorderhistory();
    // _tabController = TabController(vsync: this, length: 3);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        backgroundColor: const Color.fromARGB(255, 239, 102, 105),
        centerTitle: true,
      ),
      body: Container(
        //color: Color.fromARGB(255, 239, 102, 105),
        child: ListView(
            physics: BouncingScrollPhysics(),

          children: [

            Orders == null
                ? Loader()
                :ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 2),
                itemBuilder: (context, index) {
                  return HistCard(orders: Orders![index],
                    mp: fetchedDishes[index],); //(data: widget.stat[index]
                },
                shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: Orders!.length
            ),


          ],
        ),
      ),



    );
  }
}
