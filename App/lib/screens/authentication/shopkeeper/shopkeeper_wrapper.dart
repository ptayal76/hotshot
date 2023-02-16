import 'package:flutter/material.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/screens/authentication/shopkeeper/phone_verification.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_sign_in.dart';
import 'package:provider/provider.dart';

import '../../shopkeeper_verification_form.dart';

class ShopkeeperWrapper extends StatelessWidget {
  const ShopkeeperWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user != null) {
      return const ShopkeeperVerificationForm();
    } else {
      return const ShopkeeperSignIn();
    }
  }
}
