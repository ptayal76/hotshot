import 'package:flutter/material.dart';
import 'package:hotshot/constants/colors.dart';
import 'package:hotshot/constants/text.dart';
import 'package:hotshot/screens/shopkeeperOrdersScreen.dart';
import 'package:hotshot/widgets/sideDrawer.dart';

import '../widgets/sideDrawerShopkeeper.dart';
class ShopkeeperHome extends StatefulWidget {
  const ShopkeeperHome({Key? key}) : super(key: key);

  @override
  State<ShopkeeperHome> createState() => _ShopkeeperHomeState();
}

class _ShopkeeperHomeState extends State<ShopkeeperHome> {
  int index = 0;
  List<bool> isSelected = [true,false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: greenColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/droppedImage.jpg'),
            backgroundColor: greenColor,
          ),
        ],
        title: const Text('Restaurant Name',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      drawer: NavigationDrawer(),
      backgroundColor: Colors.brown[100],
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
        const SizedBox(height: 10),
          Row(

            children: [
              const SizedBox(width: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: greenColor,
                  minimumSize: Size(80, 50),
                ),
                onPressed: (){},
                label: Text( 'Scan QR',style: TextStyle(fontSize: 20)),
                icon: const Icon(Icons.qr_code_scanner),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: blackColor,
                  disabledBorderColor: blackColor,
                  color: Colors.green[400],
                  constraints: const BoxConstraints(
                    minHeight: 50.0,
                    minWidth: 100.0,),
                  children: const <Widget>[
                    // modified_text(text: 'Open',color: blackColor,size: 20),
                    Text( 'Open',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Text( 'Closed',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    // modified_text(text: 'Closed',color: blackColor,size: 20),

                    // Icon(Icons.ac_unit),
                    // Icon(Icons.call),
                  ],
                ),
              ),
            ],
          ),
          Row(children: const <Widget>[
            SizedBox(width: 5),
            Expanded(
                child: Divider(
                  color: blackColor,
                  thickness: 2,
                )),
            Expanded(
              child: Divider(
                color: blackColor,
                thickness: 2,
              ),
            ),
            SizedBox(width: 5),
          ]),
          Container(
            width: 20,
            height: 100,

            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton.icon(onPressed: (){},
                      icon: Icon(Icons.add),
                      label: Text('Add Items')
                  ),
                )
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              // backgroundColor: greenColor,
              minimumSize: Size(80, 50),
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShopkeeperOrdersScreen()));
            },
            // label: modified_text(text: 'Current Orders',color: blackColor,size: 20),
            label: const Text( 'Current Orders',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),

            icon: const Icon(Icons.food_bank),
          ),
        ],
      ),
    );
  }
}
