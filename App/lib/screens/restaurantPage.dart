import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/model/orders.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:hotshot/services/listdishesTomap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/loader.dart';
import '../model/orderInfo.dart';
import '../rateme.dart';
import '../services/restaurantServ.dart';
import '../widgets/buttons1.dart';

class RestaurantPage extends StatefulWidget {
  final String data;
  final String image;
  const RestaurantPage({Key? key, required this.data, required this.image})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => RestaurantPageState();
}

List x = [0.0, false];

class RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  // List x = [0.0, false];
  bool isfav = false;
  bool israted = false;
  final String phone = '9876543210';
  List<DishInfo>? dishes;
  late Orders cartforres;
  late RestInfo restaurant;
  late Map<String, int> dishesadded;

  final RestaurantServ restServ = RestaurantServ();
  fetchrestaurantbyID() async {
    RestInfo restlocal =
        await restServ.fetchRestaurantsbyID(context, widget.data);
    await fetchalldish();
    setState(() {
      restaurant = restlocal;
    });
  }

  fetchalldish() async {
    // for(int i=0;i<((widget.data.menu==[])? 0:widget.data.menu!.length);i++) {
    dishes = await restServ.fetchDish(context, restaurant.menu);
    // print(x);
    // dishes?.add(x);
    // print(i);
    // }

    print('fetchedall');
    print(dishes);
    setState(() {});
  }

  postcartdish(String dishid) async {
    await restServ.postCartOrder(context, dishid);
    setState(() {});
  }

  removecartdish(String dishid) async {
    await restServ.removeCartOrder(context, dishid);
    setState(() {});
  }

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
  void initState() {
    super.initState();
    fetchrestaurantbyID();
    // fetchalldish();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: dishes == null
          ? const Loader()
          : ColorFiltered(
              colorFilter: (restaurant.status == 'on')
                  ? const ColorFilter.mode(Colors.white, BlendMode.modulate)
                  : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
              child: Scaffold(
                body: Stack(children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Image(
                              image: NetworkImage(widget.image),
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
                                      bottomRight: Radius.circular(10))),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 4.0,
                                        top: 4.0,
                                        bottom: 4.0),
                                    child: Text(
                                      "${restaurant.rating}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const Icon(
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
                                children: [
                                  restaurant.usersRated == null
                                      ? Text('0')
                                      : Text(restaurant.usersRated!.length
                                          .toString()),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                blur: 0,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    restaurant.restaurantName,
                                    style: const TextStyle(
                                        fontSize: 28, color: Colors.white),
                                  ),
                                ),
                              )),
                          Positioned(
                              left: 10,
                              bottom: 6,
                              child: BlurryContainer(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                blur: 0,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    restaurant.location,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
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
                                  text: "TIMING",
                                  ic: Icons.access_time_outlined,
                                  onTap: () {
                                    Widget okbutton = TextButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        child: const Text(
                                          "OK",
                                          style: TextStyle(fontSize: 20),
                                        ));
                                    AlertDialog alert = AlertDialog(
                                      title: const Text("Timing"),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Text(
                                              "Opens at: " + "9:00",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Text(
                                              "Closes at: " + "17:00",
                                              style: TextStyle(fontSize: 20),
                                            ),
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
                                  text: "LOCATION",
                                  ic: Icons.location_on,
                                  onTap: () async {
                                    Uri map = Uri.parse(
                                        'https://www.google.com/maps/search/?api=1&query=26.1899,91.6984');
                                    if (await launchUrl(map)) {
                                    } else {
                                      print("error calling map");
                                    }
                                  },
                                ),
                              ),
                              Container(
                                child: new_button1(
                                  text: "CONTACT",
                                  ic: Icons.phone,
                                  onTap: () async {
                                    Uri phoneno = Uri.parse(
                                        'tel:' + restaurant.phoneNumber);
                                    if (await launchUrl(phoneno)) {
                                    } else {
                                      print("error calling log");
                                    }
                                  },
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        padding: const EdgeInsets.all(1.5),
                                        color: const Color.fromARGB(
                                            255, 239, 102, 105),
                                        child: ClipOval(
                                          child: Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.all(0.1),
                                            child: IconButton(
                                              onPressed: () async {
                                                await RestaurantServ()
                                                    .FavoriteRestaurant(
                                                        context, widget.data);
                                                setState(() {
                                                  isfav = !isfav;
                                                });
                                              },
                                              icon: Icon(
                                                isfav
                                                    ? CupertinoIcons.heart_fill
                                                    : CupertinoIcons.heart,
                                                color: isfav
                                                    ? Colors.red
                                                    : const Color.fromARGB(
                                                        255, 239, 102, 105),
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
                                            color: Color.fromARGB(
                                                255, 239, 102, 105),
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
                      (!x[1])
                          ? Container(
                              child: Builder(builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 56.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RateMe(restid: widget.data),
                                          ));
                                      // x[1] = false;
                                      // await RestaurantServ().RateRestaurant(
                                      //     context, widget.data, x[0]);
                                      // israted = (await Navigator.push(
                                      //             context,
                                      //             MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   RateMe(),
                                      //             )) ==
                                      //         null
                                      //     ? false
                                      //     : true);
                                      setState(() {});
                                      // print(x[0]);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 239, 102, 105),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0))),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 64.0),
                                      child: Text("RATE ME!",
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ),
                                );
                              }),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          // color: Color.fromARGB(255, 225, 216, 240),
                          height: 45,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 20, right: 10),
                              //   child: DropdownButton(
                              //     // Initial Value
                              //     value: dropdownvalue,
                              //
                              //     // Down Arrow Icon
                              //     icon: const Icon(Icons.keyboard_arrow_down),
                              //
                              //     // Array list of items
                              //     items: items.map((String items) {
                              //       return DropdownMenuItem(
                              //         value: items,
                              //         child: Text(
                              //           items,
                              //           style: TextStyle(fontSize: 20),
                              //         ),
                              //       );
                              //     }).toList(),
                              //     // After selecting the desired option,it will
                              //     // change button value to selected value
                              //     onChanged: (String? newValue) {
                              //       setState(() {
                              //         dropdownvalue = newValue!;
                              //       });
                              //     },
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10, right: 10),
                              //   child: ElevatedButton(
                              //     onPressed: () {
                              //       isel[0] = !isel[0];
                              //       setState(() {});
                              //     },
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.symmetric(horizontal: 8.0),
                              //       child: Text(
                              //         "Veg",
                              //         style: TextStyle(fontSize: 18),
                              //       ),
                              //     ),
                              //     style: ElevatedButton.styleFrom(
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(40.0)),
                              //       backgroundColor: (isel[0]
                              //           ? Colors.amber[400]
                              //           : Colors.grey[350]),
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //   child: ElevatedButton(
                              //     onPressed: () {
                              //       isel[1] = !isel[1];
                              //       setState(() {});
                              //     },
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.symmetric(horizontal: 8.0),
                              //       child: Text(
                              //         "Non-Veg",
                              //         style: TextStyle(fontSize: 18),
                              //       ),
                              //     ),
                              //     style: ElevatedButton.styleFrom(
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(40.0)),
                              //       backgroundColor: (isel[1]
                              //           ? Colors.amber[400]
                              //           : Colors.grey[350]),
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //   child: ElevatedButton(
                              //     onPressed: () {
                              //       isel[2] = !isel[2];
                              //       setState(() {});
                              //     },
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.symmetric(horizontal: 8.0),
                              //       child: Text(
                              //         "Breakfast",
                              //         style: TextStyle(fontSize: 18),
                              //       ),
                              //     ),
                              //     style: ElevatedButton.styleFrom(
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(40.0)),
                              //       backgroundColor: (isel[2]
                              //           ? Colors.amber[400]
                              //           : Colors.grey[350]),
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //   child: ElevatedButton(
                              //     onPressed: () {
                              //       isel[3] = !isel[3];
                              //       setState(() {});
                              //     },
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.symmetric(horizontal: 8.0),
                              //       child: Text(
                              //         "Lunch",
                              //         style: TextStyle(fontSize: 18),
                              //       ),
                              //     ),
                              //     style: ElevatedButton.styleFrom(
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(40.0)),
                              //       backgroundColor: (isel[3]
                              //           ? Colors.amber[400]
                              //           : Colors.grey[350]),
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //   child: ElevatedButton(
                              //     onPressed: () {
                              //       isel[4] = !isel[4];
                              //       setState(() {});
                              //     },
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.symmetric(horizontal: 8.0),
                              //       child: Text(
                              //         "Snacks",
                              //         style: TextStyle(fontSize: 18),
                              //       ),
                              //     ),
                              //     style: ElevatedButton.styleFrom(
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(40.0)),
                              //       backgroundColor: (isel[4]
                              //           ? Colors.amber[400]
                              //           : Colors.grey[350]),
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10, right: 20),
                              //   child: ElevatedButton(
                              //     onPressed: () {
                              //       isel[5] = !isel[5];
                              //       setState(() {});
                              //     },
                              //     child: Padding(
                              //       padding:
                              //           const EdgeInsets.symmetric(horizontal: 8.0),
                              //       child: Text(
                              //         "Dinner",
                              //         style: TextStyle(fontSize: 18),
                              //       ),
                              //     ),
                              //     style: ElevatedButton.styleFrom(
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(40.0)),
                              //       backgroundColor: (isel[5]
                              //           ? Colors.amber[400]
                              //           : Colors.grey[350]),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AbsorbPointer(
                        absorbing: (restaurant.status == 'on') ? false : true,
                        child: Container(
                          height: (9 + 161.8 * 5 + 150),
                          child: ListView.builder(
                            itemCount: dishes?.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                // Text(
                                //   "  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ",
                                //   style: TextStyle(
                                //       color: Color.fromARGB(255, 199, 198, 198)),
                                // ),
                                const Divider(
                                  thickness: 2,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12),
                                                child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      // Icon(Icons.location_pin, size: 12, color: Colors.white),
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .crop_square_sharp,
                                                            color: (dishes![index]
                                                                        .category ==
                                                                    'veg')
                                                                ? Colors.green
                                                                : Colors.red,
                                                            size: 18,
                                                          ),
                                                          Icon(Icons.circle,
                                                              color: (dishes![index]
                                                                          .category ==
                                                                      'veg')
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                              size: 7),
                                                        ],
                                                      ),
                                                    ]),
                                                // child: Image.asset(
                                                //   "assets/Veg.png",
                                                //   height: 20,
                                                // ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 244, 100, 56),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 6.0),
                                                    child: Text(
                                                      dishes![index]
                                                          .suggestedTime
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 12, bottom: 8),
                                          child: Text(
                                            dishes![index].name!,
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: Text(
                                            "₹${dishes![index].price}",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 16),
                                      child: Stack(children: [
                                        Container(
                                          height: 140,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            height: 120,
                                            width: 120,
                                            child: const Image(
                                              image: NetworkImage(
                                                  "https://d2rdhxfof4qmbb.cloudfront.net/wp-content/uploads/20200603193204/Chow-Mein.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            left: (isadd[index] ? 16.5 : 12),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          isadd[index]
                                                              ? 10
                                                              : 20),
                                                  side: const BorderSide(
                                                      color: Colors.red)),
                                              color: const Color.fromARGB(
                                                  255, 250, 235, 233),
                                              child: (isadd[index]
                                                  ? InkWell(
                                                      onTap: () {
                                                        isadd[index] = false;
                                                        itemc++;
                                                        sum += price[index];
                                                        if (itemc == 1) {
                                                          controller!.forward();
                                                        }
                                                        postcartdish(
                                                            dishes![index]
                                                                .id
                                                                .toString());
                                                        setState(() {});
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: const [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 6,
                                                                    top: 7,
                                                                    bottom: 7),
                                                            child: Text(
                                                              "ADD",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 3,
                                                                    right: 6),
                                                            child: Icon(
                                                              Icons.add,
                                                              color: Colors.red,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      children: [
                                                        IconButton(
                                                            constraints:
                                                                const BoxConstraints(),
                                                            onPressed: () {
                                                              if (count[index] >
                                                                  0) {
                                                                count[index]--;
                                                                itemc--;
                                                                sum -= price[
                                                                    index];
                                                                if (itemc ==
                                                                    0) {
                                                                  controller!
                                                                      .reverse();
                                                                }
                                                                if (count[
                                                                        index] ==
                                                                    0) {
                                                                  count[index] =
                                                                      1;
                                                                  isadd[index] =
                                                                      true;
                                                                }
                                                                removecartdish(
                                                                    dishes![index]
                                                                        .id
                                                                        .toString());
                                                                setState(
                                                                  () {},
                                                                );
                                                              }
                                                            },
                                                            icon: const Icon(
                                                              Icons.remove,
                                                            )),
                                                        Text("${count[index]}",
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        IconButton(
                                                            onPressed: () {
                                                              count[index]++;
                                                              itemc++;
                                                              sum +=
                                                                  price[index];
                                                              postcartdish(
                                                                  dishes![index]
                                                                      .id
                                                                      .toString());
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(
                                                              Icons.add,
                                                            ),
                                                            constraints:
                                                                const BoxConstraints()),
                                                      ],
                                                    )),
                                            ))
                                      ]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SlideTransition(
                      position: offset!,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 60, top: 8, left: 8, right: 8),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                          icon: const Icon(Icons.shopping_cart_outlined),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$itemc item(s) in cart",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "₹$sum",
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
    );
  }
}
