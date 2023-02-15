import 'package:flutter/material.dart';
import 'package:hotshot/constants/constants.dart';
import 'package:hotshot/model/shop_verification_info.dart';
import 'package:hotshot/screens/verification_pending.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShopkeeperVerificationForm extends StatefulWidget {
  const ShopkeeperVerificationForm({super.key});

  @override
  State<ShopkeeperVerificationForm> createState() => _ShopkeeperVerificationFormState();
}

class _ShopkeeperVerificationFormState extends State<ShopkeeperVerificationForm> {
  final List<String> locationCategoryList = ['Academic Complex', 'Food Court', 'Hostels', 'Khokha'];
  final List<String> shopTypeList = ['Eatery', 'Stationery', 'Cycle Repair', 'Laundry'];

  String? shopType;
  String? locationCategory;
  String shopName = '';
  String location = '';
  String startingTime = '';
  String closingTime = '';

  final _formKey = GlobalKey<FormState>();
  final startTimeController = TextEditingController();
  final closeTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void showToast(String message){
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 16
            ),
          ),
          closeIconColor: Theme.of(context).hintColor,
          elevation: 0,
          showCloseIcon: true,
          backgroundColor: Theme.of(context).cardColor,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('HotShot'),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 1,
        height: 65,
        destinations: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: OutlinedButton(
              onPressed: (){},
              child: const Text('Back', style: TextStyle(fontSize: 18),)
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: FilledButton(
              onPressed: ()async{
                if(_formKey.currentState!.validate())
                {
                  if(shopType == null || locationCategory == null){
                    showToast('Please fill all the fields');
                  }
                  else if(startingTime == '' || closingTime == ''){
                    showToast('Fields cannot be left empty');
                  }
                  else{
                    final shop = ShopVerificationInfo(
                      closeTime: closingTime,
                      location: location,
                      locationCategory: locationCategory!,
                      phoneNumber: '',
                      shopName: shopName,
                      shopType: shopType!,
                      startTime: startingTime
                    );

                    if(shop.shopType == 'Eatery'){
                      try {
                        const MONGO_URL = 'http://10.0.2.2:8080';
                        
                        Map<String,dynamic> body = {
                          'ownerName': 'Hardik',
                          'restaurantName': shop.shopName,
                          'phoneNumber': '1234',
                          'email': 'myemail.com',
                          'location': shop.location,
                          // 'timing': [
                          //   {
                          //     'start_time': shop.startTime
                          //   },
                          //   {
                          //     'end_time': shop.closeTime
                          //   }
                          // ],
                          'status': 'on',
                          // 'pic': Image(image: AssetImage('assets/images/iitg.jpg'),)
                        };
                        Map<String,String> customHeaders = {
                          "content-type": "application/json"
                        };
                        var pobj=jsonEncode(body);
                        print(pobj);
                        String url = MONGO_URL + '/food/rest';
                        var res = await http.post(Uri.parse(url),headers: customHeaders ,body: pobj);
                        print(res.statusCode.toString());
                        print(res.body.toString());
                        switch(res.statusCode){
                          case 200:
                            print('Success');
                            break;
                          default:
                            print('ERROR');
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    }
                  }
                }
              },
              child: const Text('Submit', style: TextStyle(fontSize: 18),)
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        'Shop Details',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextFormField(
                        validator: (value) => value == '' ? 'Field cannot be empty' : null,
                        onChanged: (value){
                          setState(() {
                            shopName = value;
                          });
                        },
                        decoration:
                        textInputDecoration.copyWith(
                          hintText: 'Shop Name',
                          prefixIcon: const Icon(Icons.label_rounded)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: InputDecorator(
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.location_city_rounded),
                          contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            onChanged: (value){
                              setState((){
                                shopType = value;
                              });
                            },
                            value: shopType,
                            hint: const Text('Shop Type'),
                            items: shopTypeList.map(
                              (shop) => DropdownMenuItem<String>(
                                value: shop,
                                child: Text(
                                  shop,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        'Location Details',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextFormField(
                        validator: (value) => value == '' ? 'Field cannot be empty' : null,
                        onChanged: (value){
                          setState(() {
                            location = value;
                          });
                        },
                        decoration:
                        textInputDecoration.copyWith(
                          hintText: 'Location',
                          prefixIcon: const Icon(Icons.location_on_rounded)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: InputDecorator(
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.location_city_rounded),
                          contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            onChanged: (value){
                              setState((){
                                locationCategory = value;
                              });
                            },
                            value: locationCategory,
                            hint: const Text('Location Category'),
                            items: locationCategoryList.map(
                              (location) => DropdownMenuItem<String>(
                                value: location,
                                child: Text(
                                  location,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        'Shop Timings',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: startTimeController,
                        readOnly: true,
                        onTap: ()async{
                          TimeOfDay? pickedTime =  await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                          );
                          if(pickedTime != null ){
                            String formattedTime = '${pickedTime.hour}:${pickedTime.minute}';
                        
                            setState(() {
                              startingTime = formattedTime;
                              startTimeController.text = formattedTime;
                            });
                          }
                          else{}
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Starting Time',
                          prefixIcon: const Icon(Icons.watch_later_outlined)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: TextFormField(
                        controller: closeTimeController,
                        readOnly: true,
                        onTap: ()async{
                          TimeOfDay? pickedTime =  await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                          );
                          if(pickedTime != null ){
                            String formattedTime = '${pickedTime.hour}:${pickedTime.minute}';
                        
                            setState(() {
                              closingTime = formattedTime;
                              closeTimeController.text = formattedTime;
                            });
                          }
                          else{}
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Closing Time',
                          prefixIcon: const Icon(Icons.watch_later_outlined)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Card(
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'These details along with your phone number will be sent to Admin for verification purpose.\nYou can add any further information about your shop after physical verification only.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
