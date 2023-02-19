import 'package:flutter/material.dart';
import 'package:hotshot/getstarted.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/screens/authentication/customer/customer_wrapper.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_wrapper.dart';
import 'package:hotshot/screens/home.dart';
import 'package:hotshot/services/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool? isCustomer;
  bool? isGoogleSignedIn;

  void checkIsGoogleSignedIn()async{
    bool? b = await SharedPrefs().isGoogleSignedIn();
    if(mounted){setState(() {
      isGoogleSignedIn = b;
    });}
  }

  void setIsCustomer() async {
    bool? b = await SharedPrefs().getIsCostumer();

    if(mounted){setState(() {
      isCustomer = b;
    });}
  }

  @override
  Widget build(BuildContext context) {
    setIsCustomer();

    final user = Provider.of<MyUser?>(context);

    if (isGoogleSignedIn == null) {
      return const Home(
        title: 'Hotshot',
      );
    } else {
      return isCustomer! ? CustomerWrapper() : ShopkeeperWrapper();
    }
  }
}
