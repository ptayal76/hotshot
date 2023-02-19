import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/constants/loading.dart';
import 'package:hotshot/services/orderServ.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

enum Options { Yes, No }

enum Options2 { Breakfast, Lunch, Dinner }

class add_item extends StatefulWidget {
  const add_item({super.key});

  @override
  State<add_item> createState() => _add_itemState();
}

class _add_itemState extends State<add_item> {
  Map<String, dynamic> m = {
    'name': '',
    'category': '',
    'suggestedTime': '',
    'price': 0,
    // 'pic': null,
    'InStock': false,
  };
  String name = "";
  String category = "";
  String suggestedTime = "";
  int price = 0;
  File? pic;
  Options? option = Options.Yes;
  Options2? option2 = Options2.Breakfast;
  File? _image;
  bool isloading = false;
  Future getImage1() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageTemp = File(image.path);
    setState(() {
      this._image = imageTemp;
    });
  }

  Future getImage2() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    final imageTemp = File(image.path);
    setState(() {
      this._image = imageTemp;
    });
  }

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return (isloading)
        ? Loading()
        : Scaffold(
            //backgroundColor: const Color.fromARGB(255, 194, 214, 231),
            appBar: AppBar(
              //backgroundColor: Colors.green,
              title: const Text(
                "Item details",
              ),
              centerTitle: true,
            ),
            body: ListView(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("We are excited to know about your new item!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Please fill the following details.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      child: Card(
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 12, left: 15),
                                child: Text(
                                  "Item name",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 16, right: 16),
                                child: TextField(
                                  controller: _nameTextController,
                                  style: const TextStyle(fontSize: 22),
                                  decoration: const InputDecoration(
                                    hintText: "Write here",
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 8,
                      ),
                      child: Card(
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 10, left: 15),
                                child: Text(
                                  "Item price(in ₹)",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 16, right: 16),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _priceTextController,
                                  style: const TextStyle(fontSize: 22),
                                  decoration: const InputDecoration(
                                      hintText: "Write here"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 8,
                      ),
                      child: Card(
                        child: Flexible(
                          child: Container(
                            //height: 125,
                            //width: 364,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 15),
                                  child: Text(
                                    "Is it veg?",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      child: ListTile(
                                        title: const Text(
                                          "Yes",
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        leading: Radio<Options>(
                                          //activeColor:
                                          // const Color.fromARGB(255, 29, 146, 33),
                                          value: Options.Yes,
                                          groupValue: option,
                                          onChanged: (Options? value) {
                                            setState(() {
                                              option = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        "No",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      leading: Radio<Options>(
                                        //activeColor: const Color.fromARGB(255, 29, 146, 33),
                                        value: Options.No,
                                        groupValue: option,
                                        onChanged: (Options? value) {
                                          setState(() {
                                            option = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 8,
                      ),
                      child: Card(
                        child: Flexible(
                          child: Container(
                            // height: 200,
                            // width: 364,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 15),
                                  child: Text(
                                    "It is taken as",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 35,
                                      child: ListTile(
                                        title: const Text(
                                          "Breakfast",
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        leading: Radio<Options2>(
                                          // activeColor:
                                          //     const Color.fromARGB(255, 29, 146, 33),
                                          value: Options2.Breakfast,
                                          groupValue: option2,
                                          onChanged: (Options2? value) {
                                            setState(() {
                                              option2 = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      child: ListTile(
                                        title: const Text(
                                          "Lunch",
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        leading: Radio<Options2>(
                                          //activeColor: const Color.fromARGB(255, 29, 146, 33),
                                          value: Options2.Lunch,
                                          groupValue: option2,
                                          onChanged: (Options2? value) {
                                            setState(() {
                                              option2 = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   height: 35,
                                    //   child: ListTile(
                                    //     title: const Text(
                                    //       "Snacks",
                                    //       style: TextStyle(fontSize: 22),
                                    //     ),
                                    //     leading: Radio<Options2>(
                                    //       // activeColor: const Color.fromARGB(255, 29, 146, 33),
                                    //       value: Options2.Snacks,
                                    //       groupValue: option2,
                                    //       onChanged: (Options2? value) {
                                    //         setState(() {
                                    //           option2 = value;
                                    //         });
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                    ListTile(
                                      title: const Text(
                                        "Dinner",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                      leading: Radio<Options2>(
                                        // activeColor: const Color.fromARGB(255, 29, 146, 33),
                                        value: Options2.Dinner,
                                        groupValue: option2,
                                        onChanged: (Options2? value) {
                                          setState(() {
                                            option2 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 8,
                      ),
                      child: Card(
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 15, bottom: 12),
                                child: Text(
                                  "Item image",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FilledButton.icon(
                                        onPressed: getImage2,
                                        icon: const Icon(Icons.camera_alt),
                                        label:
                                            const Text("Capture from camera"),
                                        style: ElevatedButton.styleFrom(
                                            //backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                      FilledButton.icon(
                                        onPressed: getImage1,
                                        icon: const Icon(Icons.image),
                                        label: const Text("Pick from gallery"),
                                        style: ElevatedButton.styleFrom(
                                            //backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: (_image != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Image.file(_image!),
                                      )
                                    : null),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 100),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_nameTextController.text == "") {
                            Widget okbutton = TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: const Text("OK"));
                            AlertDialog alert = AlertDialog(
                              title: const Text("Missing field"),
                              content: const Text("Please fill the item name."),
                              actions: [
                                okbutton,
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (context) => alert,
                              barrierDismissible: true,
                            );
                            return;
                          }
                          if (_priceTextController.text == "") {
                            Widget okbutton = TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: const Text("OK"));
                            AlertDialog alert = AlertDialog(
                              title: const Text("Missing field"),
                              content:
                                  const Text("Please fill the item price."),
                              actions: [
                                okbutton,
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (context) => alert,
                              barrierDismissible: true,
                            );
                            return;
                          }
                          if (_image == null) {
                            Widget okbutton = TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: const Text("OK"));
                            AlertDialog alert = AlertDialog(
                              title: const Text("Missing field"),
                              content: const Text("Please pick an image."),
                              actions: [
                                okbutton,
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (context) => alert,
                              barrierDismissible: true,
                            );
                            return;
                          }
                          setState(() {
                            isloading = true;
                            name = _nameTextController.text;
                            category =
                                ((option == Options.Yes) ? "veg" : "nonveg");
                            suggestedTime = ((option2 == Options2.Breakfast)
                                ? ("Breakfast")
                                : ((option2 == Options2.Dinner)
                                    ? "Dinner"
                                    : "Lunch"));
                            price = int.parse(_priceTextController.text);
                            pic = _image;
                          });

                          m['name'] = name;
                          m['category'] = category;
                          m['suggestedTime'] = suggestedTime;
                          m['price'] = price;
                          m['pic'] = pic!.path;
                          m['InStock'] = false;

                          await OrderServ().Createdish(context, m);

                          Navigator.of(context).pop(true);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text(
                          "        Submit        ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
