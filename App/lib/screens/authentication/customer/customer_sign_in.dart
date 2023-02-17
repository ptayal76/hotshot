import 'package:flutter/material.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/services/auth_service.dart';
import 'package:hotshot/services/google_auth.dart';
import 'package:hotshot/services/microsoft_auth.dart';
import 'package:hotshot/services/restaurantServ.dart';
import 'package:hotshot/services/shared_prefs.dart';
import 'package:hotshot/services/user_service.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../restHome.dart';

class CustomerSignIn extends StatefulWidget {
  const CustomerSignIn({Key? key}) : super(key: key);

  @override
  State<CustomerSignIn> createState() => _CustomerSignInState();
}

class _CustomerSignInState extends State<CustomerSignIn> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/iitg2.jpg'),
            Container(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 550,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30))),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Sign in',
                      //   style: TextStyle(fontSize: 28),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      const Text(
                        'Welcome to HotShot!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Your OneStop Solution for everything',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 28),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // const SizedBox(
                      //   height: 50,
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Lottie.asset('assets/signin1.json',
                                repeat: false),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // const Text(
                          //   'Welcome to Hotshot! Your one stop solution to everything',
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(fontSize: 15),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  icon: Image.asset(
                                    'assets/google.png',
                                    width: 32,
                                    height: 32,
                                  ),
                                  label: const Text(
                                    'Sign in with Google',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });

                                    await SharedPrefs().setIsCustomer(true);

                                    final user = await GoogleAuthentication()
                                        .googleSignIn();

                                    print(user!.fullName);

                                    // final u = MyUser(
                                    //     email: 'lohit@iitg',
                                    //     fullName: 'LOHIT HOSTEL',
                                    //     mobile: '1234321',
                                    //     uid: 'uid');

                                    print('STEP 1');

                                    final token =
                                        await UserServ().postUser(user);

                                    user.setToken(token);

                                    print(user);

                                    print(token);
                                    print('STEP 2');

                                    setState(() {
                                      loading = false;
                                    });
                                  },
                                ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                // Row(children: const <Widget>[
                                //   SizedBox(width: 30),
                                //   Expanded(
                                //       child: Divider(
                                //           // color: blackColor,
                                //           // thickness: 2,
                                //           )),
                                //   SizedBox(
                                //     width: 5,
                                //   ),
                                //   Text(
                                //     "OR",
                                //     style:
                                //         TextStyle(fontWeight: FontWeight.bold),
                                //   ),
                                //   SizedBox(width: 5),
                                //   Expanded(
                                //     child: Divider(
                                //         // color: blackColor,
                                //         // thickness: 2,
                                //         ),
                                //   ),
                                //   SizedBox(width: 30),
                                // ]),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                // ElevatedButton.icon(
                                //     icon: Image.asset(
                                //       'assets/outlook.png',
                                //       width: 32,
                                //       height: 32,
                                //     ),
                                //     label: const Text(
                                //       'Sign in with Outlook',
                                //       style: TextStyle(fontSize: 16),
                                //     ),
                                //     onPressed: () {}
                                //     // async {
                                //     //   await microsoftSignIn();
                                //     //   setState(() {
                                //     //     loading = false;
                                //     //   });
                                //     // },
                                //     ),
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
