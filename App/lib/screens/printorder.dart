import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/screens/statshopkeeperhome.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:open_file/open_file.dart';

enum Options { Portrait, Landscape }

enum Options2 { CA4, CA3, BWA4, BWA3, Poster, Certificate, PVC }

enum Options3 {Yes, No}

class PrintOrder extends StatefulWidget {
  const PrintOrder({super.key});

  @override
  State<PrintOrder> createState() => _PrintOrderState();
}

class _PrintOrderState extends State<PrintOrder> {
  Options? option = Options.Portrait;
  Options2? option2 = Options2.CA4;
  Options3? option3 = Options3.Yes;
  File? _image;
  PlatformFile? file1;
  Future getImage(ImageSource source) async {
    file1=null;
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    final imageTemp = File(image.path);
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {
      this._image = imageTemp;
    });
  }

  void _pickfile() async {
    _image=null;
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final file = result.files.first;
    file1 = file;
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
    setState(() {
      
    });
  }

  // void _openFile(PlatformFile file2){
  //   OpenFile.open(file2.path);
  // }

  final TextEditingController _copiesTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _copiesTextController.text='1';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 213, 247),
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(
              child: Text(
            "Print details",
            style: TextStyle(fontSize: 30),
          ))),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text("Make a print order",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, bottom: 12),
                        child: Text(
                          "Choose a file",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    SimpleDialog alert = SimpleDialog(
                                      title: Text("Choose an action"),
                                      children: [
                                        SimpleDialogOption(
                                            onPressed: () {
                                              getImage(ImageSource.gallery);
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(CupertinoIcons.photo,
                                                      color: Colors.blue),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(left: 2),
                                                  child: Text("Pick from gallery",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                )
                                              ],
                                            )),
                                        SimpleDialogOption(
                                            onPressed: () {
                                              getImage(ImageSource.camera);
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8),
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(left: 10),
                                                  child: Text("Capture from camera",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                )
                                              ],
                                            ))
                                      ],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (context) => alert,
                                      barrierDismissible: true,
                                    );
                                  },
                                  icon: Icon(Icons.image),
                                  label: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Choose an image"),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _pickfile,
                                  icon: Icon(Icons.file_copy),
                                  label: Text("Choose a document"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: (_image != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Image.file(_image!),
                              )
                            : null),
                      ),
                      Container(
                        child: (file1 != null
                            ? Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4,bottom: 6,left: 4),
                                child: TextButton.icon(
                                  icon: Icon(Icons.file_present,size: 25,color: Colors.black),
                                  onPressed: () {
                                    //_openFile(file1!);
                                  },
                                  label: Text(file1!.name,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.black),),
                                  ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Text("(${(file1!.size/1000000).toStringAsFixed(2)} MB)",style: TextStyle(fontSize: 20),),
                              ),
                            ],)
                            : null),
                      ),
                    ],
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
                  child: Container(
                    height: 340,
                    width: 364,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            "Choose Print option:",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  "Colored A4",
                                  style: TextStyle(fontSize: 22),
                                ),
                                leading: Radio<Options2>(
                                  activeColor: Color.fromARGB(255, 29, 146, 33),
                                  value: Options2.CA4,
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
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  "Colored A3",
                                  style: TextStyle(fontSize: 22),
                                ),
                                leading: Radio<Options2>(
                                  activeColor: Color.fromARGB(255, 29, 146, 33),
                                  value: Options2.CA3,
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
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  "Black and White A4",
                                  style: TextStyle(fontSize: 22),
                                ),
                                leading: Radio<Options2>(
                                  activeColor: Color.fromARGB(255, 29, 146, 33),
                                  value: Options2.BWA4,
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
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  "Black and White A3",
                                  style: TextStyle(fontSize: 22),
                                ),
                                leading: Radio<Options2>(
                                  activeColor: Color.fromARGB(255, 29, 146, 33),
                                  value: Options2.BWA3,
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
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  "Poster",
                                  style: TextStyle(fontSize: 22),
                                ),
                                leading: Radio<Options2>(
                                  activeColor: Color.fromARGB(255, 29, 146, 33),
                                  value: Options2.Poster,
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
                              height: 40,
                              child: ListTile(
                                title: const Text(
                                  "Certificate",
                                  style: TextStyle(fontSize: 22),
                                ),
                                leading: Radio<Options2>(
                                  activeColor: Color.fromARGB(255, 29, 146, 33),
                                  value: Options2.Certificate,
                                  groupValue: option2,
                                  onChanged: (Options2? value) {
                                    setState(() {
                                      option2 = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                "PVC print",
                                style: TextStyle(fontSize: 22),
                              ),
                              leading: Radio<Options2>(
                                activeColor: Color.fromARGB(255, 29, 146, 33),
                                value: Options2.PVC,
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
              
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                ),
                child: Card(
                  child: Container(
                    height: 125,
                    width: 364,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            "Choose orientation:",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 30,
                              child: ListTile(
                                title: const Text(
                                  "Portrait",
                                  style: TextStyle(fontSize: 22),
                                ),
                                leading: Radio<Options>(
                                  activeColor: Color.fromARGB(255, 29, 146, 33),
                                  value: Options.Portrait,
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
                                "Landscape",
                                style: TextStyle(fontSize: 22),
                              ),
                              leading: Radio<Options>(
                                activeColor: Color.fromARGB(255, 29, 146, 33),
                                value: Options.Landscape,
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

              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                ),
                child: Card(
                  child: Container(
                    height: 125,
                    width: 364,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            "Do you want it printed both sides?",
                            style: TextStyle(fontSize: 22),
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
                                leading: Radio<Options3>(
                                  activeColor: Color.fromARGB(255, 29, 146, 33),
                                  value: Options3.Yes,
                                  groupValue: option3,
                                  onChanged: (Options3? value) {
                                    setState(() {
                                      option3 = value;
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
                              leading: Radio<Options3>(
                                activeColor: Color.fromARGB(255, 29, 146, 33),
                                value: Options3.No,
                                groupValue: option3,
                                onChanged: (Options3? value) {
                                  setState(() {
                                    option3 = value;
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

              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Text(
                          "No. of copies",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 16, right: 16),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _copiesTextController,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              hintText: "Write here"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 100),
                child: ElevatedButton(
                  onPressed: () {
                    if (_copiesTextController.text == null) {
                      Widget okbutton = TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("OK"));
                      AlertDialog alert = AlertDialog(
                        title: Text("Missing field"),
                        content: Text("Please specify the number of copies."),
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
                    if (_image == null && file1==null) {
                      Widget okbutton = TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("OK"));
                      AlertDialog alert = AlertDialog(
                        title: Text("Missing file"),
                        content: Text("Please select a file."),
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
                    // Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) => StatShopkeeperHomePage(),
                    //               ));
                  },
                  child: Container(
                    width: 100,
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
