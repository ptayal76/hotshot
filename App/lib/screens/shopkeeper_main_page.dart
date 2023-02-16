import 'package:flutter/material.dart';
import 'package:hotshot/screens/accepted_orders.dart';
import 'package:hotshot/screens/shopkeeperOrdersScreen.dart';
import 'shopkeeperhome.dart';

class MainPage extends StatefulWidget {
  // final int currentIndex;
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    ShopkeeperHomePage(),
    ShopkeeperOrdersScreen(),
    AcceptedOrdersScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.menu),
            label: 'Menu',
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
