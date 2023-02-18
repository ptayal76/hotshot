import 'package:flutter/material.dart';
import 'package:hotshot/screens/accepted_orders.dart';
import 'package:hotshot/screens/shopkeeperOrdersScreen.dart';
import 'package:hotshot/screens/stationery_accepted_orders.dart';
import 'package:hotshot/screens/stationery_shopkeeperOrdersScreen.dart';
import 'package:hotshot/screens/statshopkeeperhome.dart';
import 'package:hotshot/widgets/my_shopkeeper_drawer.dart';
import 'shopkeeperhome.dart';
import '../widgets/sideDrawerShopkeeper.dart';

class StatMainPage extends StatefulWidget {
  // final int currentIndex;
  const StatMainPage({Key? key}) : super(key: key);
  @override
  State<StatMainPage> createState() => _StatMainPageState();
}

class _StatMainPageState extends State<StatMainPage> {
  var currentIndex = 0;
  // currentI = widget.currentIndex;
  final screens = [
    // new MaterialPageRoute(
    //                                     builder: (BuildContext context) =>
    //                                         ShopkeeperHomePage()),
    // new MaterialPageRoute(
    //                                     builder: (BuildContext context) =>
    //                                         ShopkeeperOrdersScreen()),
    //                                         new MaterialPageRoute(
    //                                     builder: (BuildContext context) =>
    //                                         AcceptedOrdersScreen())
    StatShopkeeperHomePage(),
    StationeryShopkeeperOrdersScreen(),
    StationeryAcceptedOrdersScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyShopkeeperDrawer(),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      // appBar: AppBar(
      //   title: const Text('Bottom Navigation Bar'),
      //   centerTitle: true,
      // ),
      // backgroundColor: Colors.brown[200],
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        // backgroundColor: Colors.grey.shade100,
        //selectedItemColor: Colors.black,
        //unselectedItemColor: Colors.white70,
        iconSize: 20,
        selectedFontSize: 16,
        unselectedFontSize: 13,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Current Orders',
            // backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Accepted Orders',
            // backgroundColor: Colors.red,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.car_rental),
          //   label: 'Rental',
          //   backgroundColor: Colors.teal,
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.line_weight_sharp),
          //   label: 'Others',
          //   backgroundColor: Colors.green,
          // ),
        ],
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
