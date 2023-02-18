import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/model/orders.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:hotshot/screens/printorder.dart';
import 'package:hotshot/screens/statshopkeeperhome.dart';
import 'package:hotshot/services/listdishesTomap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/loader.dart';
import '../model/orderInfo.dart';
import '../rateme.dart';
import '../services/restaurantServ.dart';
import '../widgets/buttons1.dart';
import 'package:lottie/lottie.dart';

class InsideStat extends StatefulWidget {
  // final String data;
  // final String image;
  const InsideStat({Key? key, /*required this.data, required this.image*/}) : super(key: key);
  @override
  State<StatefulWidget> createState() => InsideStatState();
}

class InsideStatState extends State<InsideStat> with SingleTickerProviderStateMixin {
  bool isfav = false;
  bool israted = false;
  final String phone='9876543210';
  // List<DishInfo>? dishes;
  // late Orders cartforres;
  // late RestInfo restaurant;
  // late Map<String,int> dishesadded;

  // final RestaurantServ restServ = RestaurantServ();
  // fetchrestaurantbyID() async{
  //   restaurant=await restServ.fetchRestaurantsbyID(context, widget.data);
  //   fetchalldish();
  //   setState(() {

  //   });
  // }
  // fetchalldish() async {
  //   // for(int i=0;i<((widget.data.menu==[])? 0:widget.data.menu!.length);i++) {
  //     dishes= await restServ.fetchDish(context, restaurant.menu);
  //     // print(x);
  //     // dishes?.add(x);
  //     // print(i);
  //   // }

  //   print('fetchedall');
  //   print(dishes);
  //   setState(() {

  //   });
  // }
  // postcartdish(String dishid) async {
  //   await restServ.postCartOrder(context, dishid);
  //   setState(() {

  //   });
  // }
  // removecartdish(String dishid) async {
  //   await restServ.removeCartOrder(context, dishid);
  //   setState(() {

  //   });
  // }
  final List<bool> isel = [false, false, false, false, false, false];
  String dropdownvalue = 'Below ₹1000';
  var items = [
    'Below ₹1000',
    'Below ₹500',
    'Below ₹250',
    'Below ₹100',
    'Below ₹50',
  ];
  final List<int> count = [1, 1, 1, 1, 1];
  var itemc = 0;
  final List<int> price = [100, 200, 300, 400, 500];
  var sum = 0;
  final List<bool> isadd = [
    true,
    true,
    true,
    true,
    true,
  ];
  AnimationController? controller;
  Animation<Offset>? offset;

  @override
  void initState()  {
    super.initState();
    //fetchrestaurantbyID();
    // fetchalldish();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller!);
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: /*dishes==null ? Loader():*/
      ColorFiltered(
        colorFilter: ("on"=='on') ? ColorFilter.mode(Colors.white, BlendMode.modulate):ColorFilter.mode(Colors.grey, BlendMode.saturation),
        child: Scaffold(

          body: Stack(children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Container(
                      height:250,
                      child: Image(
                        fit: BoxFit.fitHeight,
                          // image: NetworkImage(widget.image),
                          image: AssetImage('assets/images/rest1.jpg'),
                            // colorFilter: (restaurant.status=='on') ? null:new ColorFilter.mode(Colors.grey, BlendMode.saturation)
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        )),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                            )),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 4.0, top: 4.0, bottom: 4.0),
                              child: Text(
                                "4.5",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                            Icon(
                              Icons.star_rate_rounded,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 38,
                      right: 10,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Column(
                          children: const [
                            Text("124"),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 2.0),
                              child: Text("Reviews"),
                            )
                          ],
                        ),
                      ),
                    ),
                     Positioned(
                        left: 10,
                        bottom: 25,
                        child: BlurryContainer(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          blur: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'lol',
                              style: TextStyle(fontSize: 28, color: Colors.white),
                            ),
                          ),
                        )),
                     Positioned(
                        left: 10,
                        bottom: 6,
                        child: BlurryContainer(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          blur: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'pop',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: new_button1(
                              text: "TIMING", ic: Icons.access_time_outlined,
                              onTap: () {
                            Widget okbutton = TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text("OK",style: TextStyle(fontSize: 20),));
                              AlertDialog alert = AlertDialog(
                                title: Text("Timing"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text("Opens at: "+"9:00",style: TextStyle(fontSize: 20),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text("Closes at: "+"17:00",style: TextStyle(fontSize: 20),),
                                    ),
                                  ],
                                ),
                                actions: [
                                  okbutton,
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (context) => alert,
                                barrierDismissible: true,
                              );
                              },
                              ),
                        ),
                        Container(
                          child: new_button1(
                              text: "LOCATION", ic: Icons.location_on,
                              onTap: () async{
                          Uri map = Uri.parse('https://www.google.com/maps/search/?api=1&query=26.1899,91.6984');
                      if (await launchUrl(map)) {
                      }else{
                          print("error calling map");
                      }
                        },
                              ),
                        ),
                        Container(
                          child: new_button1(text: "CONTACT", ic: Icons.phone,onTap: () async{
                          Uri phoneno = Uri.parse('tel:'+ phone);
                      if (await launchUrl(phoneno)) {
                      }else{
                          print("error calling log");
                      }
                        },),
                        ),
                        Container(
                          child: Column(
                            children: [
                              ClipOval(
                                child: Container(
                                  padding: EdgeInsets.all(1.5),
                                  color: Color.fromARGB(255, 239, 102, 105),
                                  child: ClipOval(
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(0.1),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isfav = !isfav;
                                          });
                                        },
                                        icon: Icon(
                                          isfav
                                              ? CupertinoIcons.heart_fill
                                              : CupertinoIcons.heart,
                                          color: isfav ? Colors.red : Color.fromARGB(255, 239, 102, 105),
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  "FAVOURITE",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 239, 102, 105),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // (!israted)
                //     ? Container(
                //         child: Builder(builder: (context) {
                //           return Padding(
                //             padding: const EdgeInsets.symmetric(horizontal: 56.0),
                //             child: ElevatedButton(
                //               onPressed: () async {
                //                 israted = (await Navigator.push(
                //                             context,
                //                             MaterialPageRoute(
                //                               builder: (context) => RateMe(),
                //                             )) ==
                //                         null
                //                     ? false
                //                     : true);
                //                 setState(() {});
                //               },
                //               child: Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                     vertical: 8.0, horizontal: 64.0),
                //                 child: Text("RATE ME!",
                //                     style: TextStyle(fontSize: 20)),
                //               ),
                //               style: ElevatedButton.styleFrom(
                //                   backgroundColor: Color.fromARGB(255, 239, 102, 105),
                //                   shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(16.0))),
                //             ),
                //           );
                //         }),
                //       )
                //     : SizedBox(
                //         height: 0,
                //       ),
                      Lottie.asset('assets/lottie/print.json',height: 300), 
                      Padding(
                            padding: const EdgeInsets.only(left: 56,right: 56,
                            top: 4),
                            child: ElevatedButton(
                              onPressed: () {
                                 Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PrintOrder(),
                                            ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 64.0),
                                child: Text("Print Order",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 239, 102, 105),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0))),
                            ),
                          ), 
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
