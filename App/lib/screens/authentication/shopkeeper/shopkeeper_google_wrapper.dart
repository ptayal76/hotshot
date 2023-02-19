import 'package:flutter/src/widgets/framework.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_form_wrapper.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_sign_in.dart';
import 'package:hotshot/screens/shopkeeper_verification_form.dart';
import 'package:hotshot/services/shared_prefs.dart';

class ShopkeeperGoogleWrapper extends StatefulWidget {
  const ShopkeeperGoogleWrapper({super.key});

  @override
  State<ShopkeeperGoogleWrapper> createState() => _ShopkeeperGoogleWrapperState();
}

class _ShopkeeperGoogleWrapperState extends State<ShopkeeperGoogleWrapper> {


  bool postSent = false;

  bool? isGoogleSignedIn;

  void setIsGoogleSignedIn()async{
    bool? b = await SharedPrefs().isGoogleSignedIn();

    if(mounted){setState(() {
      isGoogleSignedIn = b;
    });}
  }

  @override
  Widget build(BuildContext context) {

    setIsGoogleSignedIn();

    if(isGoogleSignedIn == null){
      //either logging out or no shop
      //shop created or not
      return const ShopkeeperSignIn();
    }
    else{
      //logged in (verification form or body)
      //check shop is created or not
      return const ShopkeeperFormWrapper();
    }
  }
}