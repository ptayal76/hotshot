import 'package:flutter/material.dart';
import 'package:hotshot/constants/colors.dart';
import 'package:hotshot/screens/authentication/customer/customer_sign_in.dart';
import 'package:hotshot/screens/authentication/customer/customer_wrapper.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_wrapper.dart';
import 'package:hotshot/screens/restHome.dart';
import 'package:lottie/lottie.dart';

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
      // appBar: AppBar(
      //   title: Text(widget.title),
      //
      // ),

      body: Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images.jpeg',
              ),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0, top: 150),
                child: Container(
                  child: const Text(
                    'HOTSHOT',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        // color: Color(0xffC1C8E4))
                        color: blackColor),
                  ),
                ),
              ),
              Lottie.asset('assets/lottie/random2.json',
                  height: 300, width: 700),
              // Container(
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(image: Image.asset(assets/Hotshot-logos))
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomerWrapper()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5AB9EA),
                            minimumSize: const Size(300, 50)),
                        child: const Text(
                          'Customer Sign In',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 100.0,right: 100.0),
                    //   child: Divider(),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      // padding: const EdgeInsets.only(top:20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShopkeeperWrapper()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            minimumSize: const Size(300, 50)),
                        child: const Text(
                          'Shopkeeper Sign In',
                          style: TextStyle(fontSize: 28, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:hotshot/screens/authentication/customer/customer_sign_in.dart';
// import 'package:hotshot/screens/authentication/customer/customer_wrapper.dart';
// import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_wrapper.dart';
// import 'package:hotshot/screens/restHome.dart';

// class Home extends StatefulWidget {
//   const Home({required this.title, super.key});

//   final String title;

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const CustomerWrapper()));
//               },
//               child: const Text('Customer Sign In'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ShopkeeperWrapper()));
//               },
//               child: const Text('Shopkeeper Sign In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
