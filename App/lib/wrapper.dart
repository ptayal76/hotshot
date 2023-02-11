import 'package:flutter/material.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_wrapper.dart';
import 'package:hotshot/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return const Home(
        title: 'Hotshot',
      );
    } else {
      return const ShopkeeperWrapper();
    }
  }
}
