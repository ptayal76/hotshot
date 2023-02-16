import 'package:flutter/material.dart';
import 'package:hotshot/widgets/menuCard.dart';
// import 'package:hotshot/model/checkInfo.dart';
// import 'package:hotshot/model/checkHelper.dart';

class checkout extends StatefulWidget {
  const checkout({Key? key}) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  final List<int> count = [1, 1, 1, 1, 1];
  var itemc = 0;
  final List<int> price = [100, 200, 300, 400, 500];
  var sum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOut'),
        backgroundColor: const Color(0xff307A59),
        centerTitle: true,
      ),
      body: ListView(

        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(child: const Text('Lohit Canteen',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,)),
            ),
          ),
          ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 2),
              itemBuilder: (context, index) {
                return MenuCard(); //(data: widget.stat[index]
              },
              shrinkWrap: true,
              //scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 1,
                );
              },
              itemCount: 5
          ),
          SizedBox(
            height: 2,
            child: Container(color: Colors.black),
          ),
          SizedBox(
            height: 60,
            child:Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount : ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  Text('₹1200',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2,
            child: Container(color: Colors.black),
          ),
        ],
      ),

      bottomNavigationBar:new GestureDetector(
        onTap: ()
    {
    print("Container clicked");
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => MenuCard()));

    },
      child:Container(

        height: 50,
        decoration: BoxDecoration(color: const Color(0xff307A59)),
        child: Center(child: Text('BUY NOW : ₹1200',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),)),
      )

    ),


    );
  }
}
