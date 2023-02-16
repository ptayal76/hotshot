// import 'package:flutter/material.dart';
// import 'package:hotshot/widgets/menuCard.dart';
// import 'package:hotshot/widgets/cartCard.dart';
// // import 'package:hotshot/model/checkInfo.dart';
// import 'package:lottie/lottie.dart';
// // import 'package:hotshot/model/checkHelper.dart';
//
// class cart extends StatefulWidget {
//   const cart({Key? key}) : super(key: key);
//
//   @override
//   State<cart> createState() => _cartState();
// }
//
// class _cartState extends State<cart> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//         backgroundColor: const Color(0xff307A59),
//         centerTitle: true,
//       ),
//       body: ListView(
//
//         children: [
//           SizedBox(height:40,child: Center(child: Text('Your Orders',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),))),
//           Lottie.asset('assets/lottie/cart.json',height: 200,width: 50),
//           ListView.separated(
//               padding: EdgeInsets.symmetric(horizontal: 2),
//               itemBuilder: (context, index) {
//                 return CartCard(); //(data: widget.stat[index]
//               },
//               shrinkWrap: true,
//               //scrollDirection: Axis.vertical,
//               physics: BouncingScrollPhysics(),
//               separatorBuilder: (context, index) {
//                 return SizedBox(
//                   height: 1,
//                 );
//               },
//               itemCount: 5
//           ),
//       ]
//           ),
//     );
//   }
// }
