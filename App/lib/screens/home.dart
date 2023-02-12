import 'package:flutter/material.dart';
import 'package:hotshot/screens/authentication/customer/customer_sign_in.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_wrapper.dart';
import 'package:hotshot/screens/restHome.dart';

class Home extends StatefulWidget {
  const Home({required this.title, super.key});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerSignIn()));
              },
              child: const Text('Customer Sign In'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShopkeeperWrapper()));
              },
              child: const Text('Shopkeeper Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
