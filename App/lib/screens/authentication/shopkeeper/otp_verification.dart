import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotshot/screens/shopkeeper_home.dart';
import 'package:hotshot/constants/constants.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  String otp = '';
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
                      const Text(
                        'Phone Verification',
                        style: TextStyle(fontSize: 28),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Please enter the OTP sent via SMS to verify your phone number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Wrap(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          setState(() {
                                            otp = '$otp$value';
                                          });
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.phone,
                                      decoration: textInputDecoration,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          setState(() {
                                            otp = '$otp$value';
                                          });
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.phone,
                                      decoration: textInputDecoration,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          setState(() {
                                            otp = '$otp$value';
                                          });
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.phone,
                                      decoration: textInputDecoration,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          setState(() {
                                            otp = '$otp$value';
                                          });
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.phone,
                                      decoration: textInputDecoration,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Didn\'t receive code? Request again',
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ShopkeeperHome(),
                                          ));
                                    },
                                    child: const Text(
                                      'Verify OTP',
                                    ),
                                  ),
                                ]),
                          ],
                        ),
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
