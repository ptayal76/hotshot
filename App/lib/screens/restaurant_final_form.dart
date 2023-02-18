import 'package:flutter/material.dart';
import 'package:hotshot/constants/constants.dart';
import 'package:hotshot/services/google_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RestaurantFinalForm extends StatefulWidget {
  const RestaurantFinalForm({super.key});

  @override
  State<RestaurantFinalForm> createState() => _RestaurantFinalFormState();
}

class _RestaurantFinalFormState extends State<RestaurantFinalForm> {

  File? _image;

  Future getImage1() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageTemp = File(image.path);
    setState(() {
      _image = imageTemp;
    });
  }

  Future getImage2() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    final imageTemp = File(image.path);
    setState(() {
      _image = imageTemp;
    });
  }

  final _formKey = GlobalKey<FormState>();

  
  String dishName = '';
  String? dishCategory;
  String? suggestedTime;
  String price = '';

  List dishCategoryList = ['Veg', 'Non-Veg'];
  List suggestedTimeList = ['Breakfast', 'Lunch', 'Dinner'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleAuthentication().googleLogout();
              },
              icon: const Icon(Icons.logout))
        ],
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
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 18),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: FilledButton(
                onPressed: () async {},
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                )),
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
                        'Menu',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextFormField(
                        validator: (value) =>
                            value == '' ? 'Field cannot be empty' : null,
                        onChanged: (value) {
                          setState(() {
                            dishName = value;
                          });
                        },
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Dish Name',
                            prefixIcon: const Icon(Icons.fastfood_rounded)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: InputDecorator(
                        decoration: textInputDecoration.copyWith(
                            prefixIcon: const Icon(Icons.access_time_rounded),
                            contentPadding:
                                const EdgeInsets.fromLTRB(15, 0, 0, 0)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                suggestedTime = value;
                              });
                            },
                            value: suggestedTime,
                            hint: const Text('Suggested Time'),
                            items: suggestedTimeList
                                .map((shop) => DropdownMenuItem<String>(
                                      value: shop,
                                      child: Text(
                                        shop,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: InputDecorator(
                        decoration: textInputDecoration.copyWith(
                            prefixIcon: Stack(
                              alignment: Alignment.center,
                                children: const [
                                  Icon(
                                    Icons.crop_square_rounded,
                                    // color: (menu[index].category == 'veg')
                                    //     ? Colors.green
                                    //     : Colors.red,
                                    size: 32,
                                  ),
                                  Icon(Icons.circle,
                                      // color: (menu[index].category == 'veg')
                                      //     ? Colors.green
                                      //     : Colors.red,
                                      size: 12),
                                ],
                              ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(15, 0, 0, 0)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                dishCategory = value;
                              });
                            },
                            value: dishCategory,
                            hint: const Text('Dish Category'),
                            items: dishCategoryList
                                .map((shop) => DropdownMenuItem<String>(
                                      value: shop,
                                      child: Text(
                                        shop,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextFormField(
                        validator: (value) =>
                            value == '' ? 'Field cannot be empty' : null,
                        onChanged: (value) {
                          setState(() {
                            price = value;
                          });
                        },
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Price',
                            prefixIcon: const Icon(Icons.currency_rupee_rounded)),
                      ),
                    ),                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: InputDecorator(
                        decoration: textInputDecoration,
                        child: Flexible(
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Padding(
                              //   padding: EdgeInsets.only(
                              //       top: 10, left: 15, bottom: 12),
                              //   child: Text(
                              //     'Add dish image',
                              //     style: TextStyle(fontSize: 25),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                  // width: double.maxFinite,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FilledButton.icon(
                                        onPressed: getImage2,
                                        icon: const Icon(Icons.camera_alt),
                                        label: const Text("Capture from camera"),
                                        style: ElevatedButton.styleFrom(
                                            //backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10))),
                                      ),
                                      const SizedBox(height: 10,),
                                      FilledButton.icon(
                                        onPressed: getImage1,
                                        icon: const Icon(Icons.image_rounded),
                                        label: const Text("Pick from gallery"),
                                        style: ElevatedButton.styleFrom(
                                            //backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  
                                  image: _image == null ? null : DecorationImage(image: FileImage(_image!))
                                ),
                                // child: (_image != null ? Padding(
                                //   padding: const EdgeInsets.only(top: 16),
                                //   child: Image.file(_image!),
                                // ) : null),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}