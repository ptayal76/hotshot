import 'package:flutter/material.dart';
import 'package:hotshot/Signin.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/screens/authentication/shopkeeper/phone_verification.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_form_wrapper.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_google_wrapper.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_sign_in.dart';
import 'package:hotshot/services/shared_prefs.dart';
import 'package:provider/provider.dart';

import '../../shopkeeper_verification_form.dart';


class ShopkeeperWrapper extends StatefulWidget {
  const ShopkeeperWrapper({super.key});

  @override
  State<ShopkeeperWrapper> createState() => _ShopkeeperWrapperState();
}

class _ShopkeeperWrapperState extends State<ShopkeeperWrapper> {

  String? phone;

  void getPhoneFromPrefs()async{
    String? s = await SharedPrefs().getPhone();

    if(mounted){setState(() {
      phone = s;
    });}
  }

  @override
  Widget build(BuildContext context) {
    
    getPhoneFromPrefs();

    //final user = Provider.of<MyUser?>(context);

    if (phone != null) {
      return const ShopkeeperGoogleWrapper();
    } else {
      return const SignIn();
    }

    // if (user != null) {
    //   return const ShopkeeperFormWrapper();
    // } else {
    //   return const SignIn();
    // }
  }
}
