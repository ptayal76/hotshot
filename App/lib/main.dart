import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/screens/cart.dart';
import 'package:hotshot/screens/home.dart';
import 'package:hotshot/screens/restHome.dart';
import 'package:hotshot/services/auth_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RestHome(),
    );
  }
}

//
// void main()  {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp(
//   //   options: DefaultFirebaseOptions.currentPlatform,
//   // );
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // return StreamProvider<MyUser?>.value(
//     //   value: AuthService().user,
//     //   initialData: null,
//     //   child: MaterialApp(
//     //     debugShowCheckedModeBanner: false,
//     //     title: 'Hotshot',
//     //     theme: ThemeData(
//     //         useMaterial3: true,
//     //         brightness: Brightness.dark,
//     //         colorSchemeSeed: const Color(0xff307A59)),
//     //     home: Cart()
//     //   ),
//     // );
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Cart(),
//     );
//   }
// }
