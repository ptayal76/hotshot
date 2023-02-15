import 'package:flutter/material.dart';
import 'package:hotshot/model/orders.dart';

import '../model/restHelper.dart';
import '../widgets/orderCard.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);
  final List<Orders> topPicks = RestHelper.cartOrders;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return OrderCard(data: widget.topPicks[index]);
        },
        shrinkWrap: true,
        //scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 16,
          );
        },
        itemCount: widget.topPicks.length);
  }
}
