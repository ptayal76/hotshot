import 'package:flutter/material.dart';
import 'package:hotshot/services/payment_service.dart';
import 'package:hotshot/widgets/my_drawer.dart';

class StationeryOrder extends StatefulWidget {
  const StationeryOrder({super.key});

  @override
  State<StationeryOrder> createState() => _StationeryOrderState();
}

class _StationeryOrderState extends State<StationeryOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HotShot'),
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: ElevatedButton(
          onPressed: ()async{
            await PaymentService().checkOut();
          },
          child: const Text('Submit'),
        )
      ),
    );
  }
}