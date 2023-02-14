import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/screens/cart.dart';
import 'package:hotshot/screens/home.dart';
import 'package:hotshot/screens/restHome.dart';
import 'package:hotshot/screens/authentication/customer/customer_sign_in.dart';
import 'package:hotshot/screens/home.dart';
import 'package:hotshot/screens/restHome.dart';
import 'package:hotshot/screens/shopkeeperOrdersScreen.dart';
import 'package:hotshot/screens/shopkeeper_home.dart';
import 'package:hotshot/screens/shopkeeper_main_page.dart';
import 'package:hotshot/screens/shopkeeperhome.dart';
import 'package:hotshot/screens/stationery_accepted_orders.dart';
import 'package:hotshot/screens/stationery_shopkeeperOrdersScreen.dart';
import 'package:hotshot/services/auth_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: RestHome(),
        theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: const Color(0xff307A59)),
        home: ShopkeeperOrdersScreen()
        // home: Home(
        //   title: 'HotShot',
        // ),
        );
    // home: RestHome(),
  }
}
