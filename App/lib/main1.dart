import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/rateme.dart';
import 'package:hotshot/widgets/buttons1.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RestaurantHome(),
    );
  }
}

class RestaurantHome extends StatefulWidget {
  const RestaurantHome({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantHomeState();
}

class RestaurantHomeState extends State<RestaurantHome>
    with SingleTickerProviderStateMixin {
  bool isfav = false;
  bool israted = false;
  final List<bool> isel = [false, false, false, false, false, false];
  String dropdownvalue = 'Below ₹1000';
  var items = [
    'Below ₹1000',
    'Below ₹500',
    'Below ₹250',
    'Below ₹100',
    'Below ₹50',
  ];
  final List<int> count = [0, 0, 0, 0, 0];
  var itemc = 0;
  AnimationController? controller;
  Animation<Offset>? offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller!);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: [
          ListView(
            children: [
              Stack(
                children: [
                  Container(
                    child: const Image(
                        image: NetworkImage(
                            "https://tse1.mm.bing.net/th?id=OIP.1TubNvwR54s7oy0sdAaKZAHaE7&pid=Api&P=0")),
                  ),
                  IconButton(
                      onPressed: () {},
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
                              topRight: Radius.circular(10))),
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
                  const Positioned(
                      left: 10,
                      bottom: 20,
                      child: BlurryContainer(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        blur: 4,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Lohit canteen",
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                        ),
                      )),
                  const Positioned(
                      right: 8,
                      bottom: 6,
                      child: BlurryContainer(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        blur: 4,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Lohit hostel",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                            text: "TIMING", ic: Icons.access_time_outlined),
                      ),
                      Container(
                        child: new_button1(
                            text: "LOCATION", ic: Icons.location_on),
                      ),
                      Container(
                        child: new_button1(text: "CONTACT", ic: Icons.phone),
                      ),
                      Container(
                        child: Column(
                          children: [
                            ClipOval(
                              child: Container(
                                padding: EdgeInsets.all(1.5),
                                color: Colors.blue,
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
                                        color: isfav ? Colors.red : Colors.blue,
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
                                    color: Colors.blue,
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
              (!israted)
                  ? Container(
                      child: Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 56.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              // israted = (await Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) => RateMe(),
                              //             )) ==
                              //         null
                              //     ? false
                              //     : true);
                              // setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 64.0),
                              child: Text("RATE ME!",
                                  style: TextStyle(fontSize: 20)),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0))),
                          ),
                        );
                      }),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  color: Color.fromARGB(255, 225, 216, 240),
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            isel[0] = !isel[0];
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Veg",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                            backgroundColor: (isel[0]
                                ? Colors.amber[400]
                                : Colors.grey[350]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            isel[1] = !isel[1];
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Non-Veg",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                            backgroundColor: (isel[1]
                                ? Colors.amber[400]
                                : Colors.grey[350]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            isel[2] = !isel[2];
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Breakfast",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                            backgroundColor: (isel[2]
                                ? Colors.amber[400]
                                : Colors.grey[350]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            isel[3] = !isel[3];
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Lunch",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                            backgroundColor: (isel[3]
                                ? Colors.amber[400]
                                : Colors.grey[350]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            isel[4] = !isel[4];
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Snacks",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                            backgroundColor: (isel[4]
                                ? Colors.amber[400]
                                : Colors.grey[350]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            isel[5] = !isel[5];
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Dinner",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                            backgroundColor: (isel[5]
                                ? Colors.amber[400]
                                : Colors.grey[350]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: (118 + 127.75 * 5),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color.fromARGB(255, 225, 241, 243),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://tse2.mm.bing.net/th?id=OIP.Jd-H-LHiVSkNBlLR65nuVwHaEK&pid=Api&P=0'))),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 50, left: 50),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 201, 199, 199),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 16.0),
                                          child: Text(
                                            "Dinner",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: Image.asset(
                                      "assets/Veg.png",
                                      height: 20,
                                    ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, left: 12),
                                child: Text(
                                  "Mexican pizza",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: Text(
                                      "₹ 400",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border(
                                              bottom: BorderSide(width: 1.0),
                                              left: BorderSide(width: 1.0),
                                              right: BorderSide(width: 1.0),
                                              top: BorderSide(width: 1.0))),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (count[index] > 0) {
                                                count[index]--;
                                                itemc--;
                                                if (itemc == 0) {
                                                  controller!.reverse();
                                                }
                                                setState(
                                                  () {},
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.remove),
                                            color: Colors.red,
                                          ),
                                          Text(
                                            "${count[index]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              count[index]++;
                                              itemc++;
                                              if (itemc == 1) {
                                                controller!.forward();
                                              }
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.add),
                                            color:
                                                Color.fromARGB(255, 16, 92, 19),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  physics: NeverScrollableScrollPhysics(),
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
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 140, bottom: 16, top: 16),
                        child: Text(
                          "$itemc item(s) in cart",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(
                        "₹${400 * itemc}",
                        style: TextStyle(fontSize: 20),
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
    );
  }
}
