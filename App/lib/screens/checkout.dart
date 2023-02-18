import 'package:flutter/material.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/services/listdishesTomap.dart';
import 'package:hotshot/services/orderServ.dart';
import 'package:hotshot/widgets/menuCard.dart';
import 'package:hotshot/theme_provider.dart';
import 'package:hotshot/constants/globvar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:hotshot/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:fluttertoast/fluttertoast.dart';
import '../constants/loading.dart';
import '../model/orderInfo.dart';
import '../services/restaurantServ.dart';
// import 'package:hotshot/services/listdishesTomap.dart';
// import 'package:hotshot/model/checkInfo.dart';
// import 'package:hotshot/model/checkHelper.dart';

class checkout extends StatefulWidget {
  // final String orderID;
  final Order order;
  const checkout({Key? key, required this.order}) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {

  Order? refOrder;
  Map<String, int> dishes = {};
  Map<DishInfo, int> fetchedDishes = {};
  fetchorder() async {
    refOrder = await OrderServ().fetchOrderbyId(context, widget.order.id);
    fetchmenu();
    // setState(() {
    //
    // });
  }
  fetchmenu() async{
    dishes=convert().listToMap(refOrder!.items);
    List<String> dishIdsOrder=[];
    // print("keeyyyy11111111");
    for(String key in dishes!.keys.toList()){
      // print(key);
      // print("keyyyyysssss");
      dishIdsOrder.add(key);
    }
    List<DishInfo> x = await RestaurantServ().fetchDish(context, dishIdsOrder);
    Map<DishInfo, int> mp = {};
    for (int j = 0; j < x.length; j++) {
      mp[x[j]] = dishes[x[j].id]!;
    }
    fetchedDishes = (mp);
    setState(() {});
  }
  postcartdish(String dishid) async {
    await RestaurantServ().postCartOrder(context, dishid);
    setState(() {

    });
  }
  removecartdish(String dishid) async {
    await RestaurantServ().removeCartOrder(context, dishid);
    setState(() {

    });
  }
  // fetchListMenu() async{
  //   List<DishInfo>x=await RestaurantServ().fetchDish(context, );
  // }
  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    fetchorder();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options=await OrderServ().checkout(context, refOrder!.id);
    // Map<String,String> mp= (options==null)? {}: mp;
    print(options);
    // var options = {
    //   'key': 'rzp_test_gFnmcZ4eyzXm04',
    //   // 'amount': 28200,
    //   // 'name': 'Shaiq',
    //   'order_id': 'order_LGlIPFgYCY7pxn',
    //   // 'description': 'Payment',
    //   // 'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    //   // 'external': {
    //   //   'wallets': ['paytm']
    //   // }
    // };

    try {
      _razorpay.open({
        'order_id':'${options!['orderid']}',
        'key': '${options!['keyid']}'
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    try {
      Map<String,dynamic> json = {'razorpay_payment_id': '${response.paymentId}'};
      print(response.toString());
      print(response.runtimeType);
      print(response.signature.toString());
      print(response.orderId.toString());
      await OrderServ().acknowledge(context, refOrder!.id, json);
      Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId}",
        timeInSecForIosWeb: 4,
      );
    }
    catch(e)
    {
      print(e);
    }


  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: ${response.code} - ${response.message}",
      timeInSecForIosWeb: 4,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: ${response.walletName}",
      timeInSecForIosWeb: 4,
    );
  }

  final List<int> count = [1, 1, 1, 1, 1];
  var itemc = 0;
  final List<int> price = [100, 200, 300, 400, 500];
  var sum = 0;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    //final themeProvider = Provider.of<ThemeProvider>(context);

    fetchorder();
    return (refOrder==null)?Loading():Scaffold(
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
            child: Center(
              child: Text((allRest[widget.order.restaurantId]!.restaurantName),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 2),
              itemBuilder: (context, index) {
                DishInfo key=fetchedDishes.keys.elementAt(index);
                int value=fetchedDishes.values.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuCard(dish: key,freq: value),
                          Container(

                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        removecartdish(fetchedDishes.keys.elementAt(index).id);
                                      },
                                        icon: Icon(
                                          Icons.remove,
                                          size: 15,
                                        ),
                                        style: ButtonStyle( backgroundColor: MaterialStatePropertyAll<Color>(themeProvider.isDarkMode?Colors.white12:Colors.black12),),),


                                      Text(value.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                                      // Container(width: 2,color: Colors.black,),
                                      // SizedBox(width: 2,child: Container(color: Colors.red,),),
                                      IconButton(onPressed: (){
                                        postcartdish(fetchedDishes.keys.elementAt(index).id);
                                        fetchorder();
                                      },
                                        icon: Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        style: ButtonStyle( backgroundColor: MaterialStatePropertyAll<Color>(themeProvider.isDarkMode?Colors.white12:Colors.black12),),

                                      ),

                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    //border: Border.all(width: 0.2,color: Colors.red),
                                    borderRadius: BorderRadius.circular(28.0),
                                    // color: Colors.red[50]

                                  ),
                                ),
                                // SizedBox(height: 5,),
                                Text('₹'+(value*(fetchedDishes.keys.elementAt(index).price!)).toString() , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
                                //
                              ],
                            ),

                          ),


                        ],
                      ),

                    ],
                  ),
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
              itemCount: fetchedDishes.length),
          Divider(),
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount : ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${refOrder!.total.toString()}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 20),
            child: new GestureDetector(
                onTap: ()
                {
                  print("Container clicked");
                  openCheckout();
                  // Navigator.pushReplacement(context,
                  //     new MaterialPageRoute(builder: (BuildContext context) => MenuCard()));

                },
                child:Container(

                  height: 50,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 239, 102, 105)),
                  child: Center(
                      child: Text(
                    'BUY NOW : ₹${refOrder!.total.toString()}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                )),
          );
  }
}
