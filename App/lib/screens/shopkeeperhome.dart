import 'dart:typed_data';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/constants/loading.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/screens/add_item_page.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:hotshot/services/auth_service.dart';
import 'package:hotshot/services/restaurantServ.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/sideDrawerShopkeeper.dart';

class ShopkeeperHomePage extends StatefulWidget {
  const ShopkeeperHomePage({Key? key}) : super(key: key);

  @override
  State<ShopkeeperHomePage> createState() => _ShopkeeperHomePageState();
}

class _ShopkeeperHomePageState extends State<ShopkeeperHomePage> {
  var textEditingController = TextEditingController();
  int index = 0;

  bool isLoading = true;

  List<bool> isSelected = [true, false];

  List<DishInfo> menu = [];
  String restName = '';

  void getData(BuildContext context)async{

    final tkn = await AuthService().getToken();

    List<DishInfo>? result = await RestaurantServ().fetchMenu(context, tkn!);
    RestInfo restaurant = await RestaurantServ().fetchRestaurantsbyID(context, tkn!);

    setState(() {
      menu = result ?? [];
      restName = restaurant.restaurantName;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD METHOD RAN');
    getData(context);


    return isLoading ? const Loading() : Scaffold(
      appBar: AppBar(
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/droppedImage.jpg'),
          ),
        ],
        title: Text(restName,),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  label: const Text('Scan QR', style: TextStyle(fontSize: 18)),
                  icon: const Icon(Icons.qr_code_scanner),
                ),
                ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text('Open',
                          style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text('Closed',
                          style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
      ),
      drawer: MyNavigationDrawer(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimSearchBar(
                    width: 250,
                    textController: textEditingController,
                    onSuffixTap: () {},
                    onSubmitted: (p0) => "",
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => add_item(),
                                          ));


                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Items')),
                  ),
                ],
              ),
            ),
          ),

          // ElevatedButton.icon(
          //   style: ElevatedButton.styleFrom(
          //     // backgroundColor: greenColor,
          //     minimumSize: Size(80, 50),
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => ShopkeeperOrdersScreen()));
          //   },
          //   // label: modified_text(text: 'Current Orders',color: blackColor,size: 20),
          //   label: const Text('Current Orders',
          //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          //   icon: const Icon(Icons.food_bank),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: menu.length,
              itemBuilder:  (context, index){
              bool imgavail=false;
              menu[index].pic==null? imgavail=false:imgavail=true;
              List<int> bufferInt= (imgavail)?menu[index].pic!.map((e) => e as int).toList():[];
              Image img=(imgavail)?Image.memory(Uint8List.fromList(bufferInt)):Image.asset('assets/images/restdefault.webp');
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.transparent),
                          image: DecorationImage(
                            image: img.image,
                            // colorFilter: (menu[index].status=='on') ? null:new ColorFilter.mode(Colors.grey, BlendMode.saturation),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.white)),
                          color:
                              (menu[index].InStock! ? Colors.green : Colors.red),
                          child: InkWell(
                              onTap: () {
                                // instock = !instock;
                                // itemc++;
                                // if (itemc == 1) {
                                //   controller!.forward();
                                // }
                                setState(() {});
                              },
                              child: (menu[index].InStock!
                                  ? const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "In stock",
                                        style: TextStyle(
                                            //fontSize: 15,
                                            // color: Colors.white,
                                            fontWeight:
                                                FontWeight.w500),
                                      ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Out of stock",
                                        style: TextStyle(
                                            fontSize: 15,
                                            // color: Colors.white,
                                            fontWeight:
                                                FontWeight.w500),
                                      ),
                                    ))))
                    ]),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Stack(
                                alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.crop_square_sharp,
                                      color: (menu[index].category == 'veg')
                                          ? Colors.green
                                          : Colors.red,
                                      size: 18,
                                    ),
                                    Icon(Icons.circle,
                                        color: (menu[index].category == 'veg')
                                            ? Colors.green
                                            : Colors.red,
                                        size: 9),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color:
                                        Color.fromARGB(255, 244, 100, 56),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(6)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 6.0),
                                    child: Text(
                                      menu[index].suggestedTime ?? 'null',
                                      style: const TextStyle(
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12),
                          child: Text(
                            menu[index].name!,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                '₹${menu[index].price}',
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w700),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
              }
            )
          )
        ]
      ),
    );
  }
}
