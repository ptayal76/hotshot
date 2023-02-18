import 'dart:typed_data';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/constants/constants.dart';
import 'package:hotshot/constants/loading.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/screens/add_item_page.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:hotshot/services/auth_service.dart';
import 'package:hotshot/services/orderServ.dart';
import 'package:hotshot/services/restaurantServ.dart';
import 'package:hotshot/services/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import '../widgets/my_shopkeeper_drawer.dart';
import '../widgets/sideDrawerShopkeeper.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hotshot/screens/shopkeeper_main_page.dart';

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

  void getData(BuildContext context) async {
    final tkn = await SharedPrefs().getToken();
    final restID =
        await (await SharedPreferences.getInstance()).getString('restID');

    //final tkn = '';
    List<DishInfo>? result = await RestaurantServ().fetchMenu(context, restID!);

    RestInfo restaurant =
        await RestaurantServ().fetchRestaurantsbyID(context, restID);

    if (mounted) {
      setState(() {
        menu = result ?? [];
        //restName = restaurant.restaurantName;
        isLoading = false;
      });
    }
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

    return isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              actions: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/droppedImage.jpg'),
                ),
              ],
              title: Text(
                restName,
              ),
              centerTitle: true,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilledButton.icon(
                          onPressed: () {
                            //starting
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return MyQR();
                              },
                            ));
                            return;
                          },
                          label: const Text('Scan QR',
                              style: TextStyle(fontSize: 18)),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
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
                  )),
            ),
            drawer: MyShopkeeperDrawer(),
            body: Column(children: <Widget>[
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
                      itemBuilder: (context, index) {
                        bool imgavail = false;
                        menu[index].pic == null
                            ? menu[index].pic='https://assets.bonappetit.com/photos/6216890f38d007bf4cbb587c/master/w_1600,c_limit/20220215%20Big%20Falafel%20LEDE.jpg'
                            : imgavail = true;
                        // List<int> bufferInt = (imgavail)
                        //     ? menu[index].pic!.map((e) => e as int).toList()
                        //     : [];
                        // Image img = (imgavail)
                        //     ? Image.memory(Uint8List.fromList(bufferInt))
                        //     : Image.asset('assets/images/restdefault.webp');
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
                                        border: Border.all(
                                            color: Colors.transparent),
                                        image: DecorationImage(
                                          image: NetworkImage(menu[index].pic!),
                                          // colorFilter: (menu[index].status=='on') ? null:new ColorFilter.mode(Colors.grey, BlendMode.saturation),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                                color: Colors.white)),
                                        color: (menu[index].InStock!
                                            ? Colors.green
                                            : Colors.red),
                                        child: InkWell(
                                            onTap: () async {
                                              // instock = !instock;
                                              // itemc++;
                                              // if (itemc == 1) {
                                              //   controller!.forward();
                                              // }
                                              await (OrderServ().InOutStock(
                                                  context, menu[index].id));
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
                                                    padding:
                                                        EdgeInsets.all(8.0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Icon(
                                                Icons.crop_square_sharp,
                                                color: (menu[index].category ==
                                                        'veg')
                                                    ? Colors.green
                                                    : Colors.red,
                                                size: 18,
                                              ),
                                              Icon(Icons.circle,
                                                  color:
                                                      (menu[index].category ==
                                                              'veg')
                                                          ? Colors.green
                                                          : Colors.red,
                                                  size: 9),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 244, 100, 56),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 6.0),
                                              child: Text(
                                                menu[index].suggestedTime ??
                                                    'null',
                                                style: const TextStyle(
                                                    // color: Colors.white,
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
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      menu[index].name!,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Text(
                                          '₹${menu[index].price}',
                                          style: const TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await OrderServ().RemoveItem(
                                              context, menu[index].id);
                                              setState(() {
                                                
                                              });
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }))
            ]),
          );
  }
}

class MyQR extends StatefulWidget {
  const MyQR({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyQRState();
}

class _MyQRState extends State<MyQR> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          // Expanded(
          //   flex: 1,
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         if (result != null)
          //           Text(
          //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
          //         else
          //           const Text('Scan a code'),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 0,
          borderLength: 10,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      var snack;
      print(result!.code);
      print(result!.code.runtimeType);
      if (result != null) {
        try {
          final response = await http.put(Uri.parse(
              '$MONGO_URL/food/rest/complete/${jsonDecode((result?.code)!)['orderid']}'));
          if (response.statusCode == 200) {
            print("success");
            snack = SnackBar(
              content: Text('Order completed.'),
              backgroundColor: Colors.green,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(5),
            );
          } // 14.139.196.13
        } catch (e) {
          print("error");
          snack = SnackBar(
            content: Text('Irrelevant QR.'),
            backgroundColor: Colors.green,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          );
        }
        //print("${response.body}'\n''\n''\n''\n''\n''\n''\n''\n''\n''\n''\n''\n''\n''\n''\n''\n''\n'");
        //   if (response.statusCode == 200) {
        //   print("success");
        //      snack = SnackBar(
        //           content: Text('Order completed.'),
        //           backgroundColor: Colors.green,
        //           elevation: 10,
        //           behavior: SnackBarBehavior.floating,
        //           margin: EdgeInsets.all(5),
        //         );
        //   } // 14.139.196.13
        //   else {
        //   print("error");
        //   snack = SnackBar(
        //           content: Text('Irrelevant QR.'),
        //           backgroundColor: Colors.green,
        //           elevation: 10,
        //           behavior: SnackBarBehavior.floating,
        //           margin: EdgeInsets.all(5),
        //         );
        //  }
        ScaffoldMessenger.of(context).showSnackBar(snack);
        //Navigator.of(context).pop(true);
        //dispose();
        controller.stopCamera();
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return MainPage();
          },
        ));
        return;
      }
      //starting
      setState(() {});
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
  //starting

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
}
