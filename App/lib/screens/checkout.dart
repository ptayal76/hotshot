import 'package:flutter/material.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/services/listdishesTomap.dart';
import 'package:hotshot/services/orderServ.dart';
import 'package:hotshot/widgets/menuCard.dart';
import 'package:hotshot/constants/globvar.dart';
import '../model/orderInfo.dart';
import '../services/restaurantServ.dart';
// import 'package:hotshot/services/listdishesTomap.dart';
// import 'package:hotshot/model/checkInfo.dart';
// import 'package:hotshot/model/checkHelper.dart';

class checkout extends StatefulWidget {
  // final String orderID;
  final Order order;
  const checkout({Key? key,required this.order}) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  Order? refOrder;
  Map<String,int> dishes={};
  Map<DishInfo,int> fetchedDishes={};
  fetchorder() async{
    refOrder=await OrderServ().fetchOrderbyId(context,widget.order.id);
    fetchmenu();
    setState(() {

    });
  }
  fetchmenu() async{
    dishes=convert().listToMap(refOrder!.items);
    List<String> dishIdsOrder=[];
    print("keeyyyy11111111");
    for(String key in dishes!.keys.toList()){
      print(key);
      print("keyyyyysssss");
      dishIdsOrder.add(key);
    }
    List<DishInfo>x=await RestaurantServ().fetchDish(context, dishIdsOrder);
    Map<DishInfo,int>mp={};
    for(int j=0;j<x!.length;j++){
      mp[x[j]]=dishes![x[j].id]!;
    }
    fetchedDishes=(mp);
    setState(() {

    });
  }
  // fetchListMenu() async{
  //   List<DishInfo>x=await RestaurantServ().fetchDish(context, );
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchorder();
    // _tabController = TabController(vsync: this, length: 3);
  }
  final List<int> count = [1, 1, 1, 1, 1];
  var itemc = 0;
  final List<int> price = [100, 200, 300, 400, 500];
  var sum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOut'),
        backgroundColor: const Color(0xff307A59),
        centerTitle: true,
      ),
      body: ListView(

        children: [
          Container(
            height: 50,
            // decoration: BoxDecoration(color: Colors.white),
            child: Center(child: Text((allRest[widget.order.restaurantId]!.restaurantName),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,)),
            ),
          ),
          ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 2),
              itemBuilder: (context, index) {
                DishInfo key=fetchedDishes.keys.elementAt(index);
                int value=fetchedDishes.values.elementAt(index);
                return MenuCard(dish: key,freq: value); //(data: widget.stat[index]
              },
              shrinkWrap: true,
              //scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 1,
                );
              },
              itemCount: fetchedDishes.length
          ),
          SizedBox(
            height: 2,
            child: Container(color: Colors.black),
          ),
          SizedBox(
            height: 60,
            child:Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount : ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  Text('₹${refOrder!.total.toString()}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2,
            child: Container(color: Colors.black),
          ),
        ],
      ),

      bottomNavigationBar:new GestureDetector(
        onTap: ()
    {
    print("Container clicked");
    // Navigator.pushReplacement(context,
    //     new MaterialPageRoute(builder: (BuildContext context) => MenuCard()));

    },
      child:Container(

        height: 50,
        decoration: BoxDecoration(color: const Color(0xff307A59)),
        child: Center(child: Text('BUY NOW : ₹${refOrder!.total.toString()}',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),)),
      )

    ),


    );
  }
}
