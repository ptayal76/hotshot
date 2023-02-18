import 'dart:typed_data';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/constants/loading.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/screens/add_item_page.dart';
import 'package:hotshot/model/restInfo.dart';
import 'package:hotshot/screens/stat_shopkeeper_main_page.dart';
import 'package:hotshot/services/auth_service.dart';
import 'package:hotshot/services/restaurantServ.dart';
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
import 'package:swipe_to/swipe_to.dart';

class StatShopkeeperHomePage extends StatefulWidget {
  const StatShopkeeperHomePage({Key? key}) : super(key: key);

  @override
  State<StatShopkeeperHomePage> createState() => _StatShopkeeperHomePageState();
}

class _StatShopkeeperHomePageState extends State<StatShopkeeperHomePage> {
  var textEditingController = TextEditingController();
  int index = 0;

  // bool isLoading = true;
  // final TextEditingController pricecontroller=TextEditingController();
  List<bool> isSelected = [true, false];
  List<String> categories=['Colored A4', 'Colored A3', 'Black and White A4', 'Black and White A3', 'Poster', 'Certificate', 'PVC Print', ];
  List<int> prices= [0,0,0,0,0,0,0];
  List<bool> available= [false, false, false, false, false, false, false, ];
  List<TextEditingController>pricecontroller=[TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),];

  List<DishInfo> menu = [];
  String restName = '';

  // void getData(BuildContext context)async{

  //   final tkn = await AuthService().getToken();

  //   List<DishInfo>? result = await RestaurantServ().fetchMenu(context, tkn!);
  //   RestInfo restaurant = await RestaurantServ().fetchRestaurantsbyID(context, tkn);

  //   setState(() {
  //     menu = result ?? [];
  //     restName = restaurant.restaurantName;
  //     isLoading = false;
  //   });
  // }
  Future<void> _displayTextInputDialog(BuildContext context,int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter new price (in ₹)'),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: pricecontroller[index],
            decoration: InputDecoration(hintText: "Write here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                print(pricecontroller[index].text);
                Navigator.pop(context);
                setState(() {
                  
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('BUILD METHOD RAN');
    // getData(context);


    return //isLoading ? const Loading() : 
    Scaffold(
      drawer: MyShopkeeperDrawer(),
      appBar: AppBar(
        
        
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
                  onPressed: () {
                    //starting
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyQR2();
                          },
                        ));
        return;
                  },
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
      //drawer: MyNavigationDrawer(),
      body: ListView.builder(
            itemCount: 8,
            itemBuilder:  (context, index){
            return (index!=7)?SwipeTo(
              onLeftSwipe: () {
                setState(() {
                  available[index]=false;
                });
              },
              onRightSwipe: () {
                setState(() {
                  available[index]=true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(available[index]?Icons.check:Icons.close),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12),
                          child: Text(
                            categories[index],
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(((pricecontroller[index].text=='')?"₹0":"₹${pricecontroller[index].text}"),style: TextStyle(fontSize: 25)),
                        IconButton(
                          onPressed: () {
                            _displayTextInputDialog(context,index);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ):
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Swipe right to make the category available.",style: TextStyle(fontWeight: FontWeight.w500),),
                      Text("("),
                      Icon(Icons.check,size: 18,),
                      Text(")"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Swipe left to make the category unavailable.",style: TextStyle(fontWeight: FontWeight.w500),),
                      Text("("),
                      Icon(Icons.close,size: 18,),
                      Text(")"),
                    ],
                  ),
                ],
              ),
            )
            ;
            }
          )
    );
  }
}

class MyQR2 extends StatefulWidget {
  const MyQR2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyQR2State();
}

class _MyQR2State extends State<MyQR2> {
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
      onQRViewCreated: _onQRView2Created,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 0,
          borderLength: 10,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRView2Created(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) async{
      result = scanData;
      var snack;
      print(result!.code);
      print(result!.code.runtimeType);
      if(result!=null){
        try {
          final response = await http.put(Uri.parse('http://192.168.1.106:8080/food/rest/complete/${jsonDecode((result?.code)!)['orderid']}'));
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
        controller.stopCamera();
        //dispose();
        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return StatMainPage();
                          },
                        ));
        return;
      }
      //starting
      setState(() {
        
      });
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

