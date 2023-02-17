import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotshot/services/orderServ.dart';

class QrScreen extends StatefulWidget {
  List<dynamic>? pic;
  QrScreen({Key? key,required this.pic}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchqr();
  //   // _tabController = TabController(vsync: this, length: 3);
  // }
  @override
  Widget build(BuildContext context) {
    List<int> bufferInt= widget.pic!.map((e) => e as int).toList();
    Image img=Image.memory(Uint8List.fromList(bufferInt));
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
        ),
        elevation: 1,
        title: const Text('HotShot'),
      ),
      body: (widget.pic==null)?Center(
          child: CircularProgressIndicator()
      ):Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: img.image,
              // colorFilter: (widget.data.status=='on') ? null:new ColorFilter.mode(Colors.grey, BlendMode.saturation),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
