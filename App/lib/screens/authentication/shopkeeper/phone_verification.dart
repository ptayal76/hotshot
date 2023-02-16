import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotshot/screens/authentication/shopkeeper/otp_verification.dart';
import 'package:hotshot/services/auth_service.dart';
import 'package:lottie/lottie.dart';
import 'package:hotshot/constants/constants.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {

  final _formKey = GlobalKey<FormState>();

  String phoneNum = '';

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
                        'Sign in',
                        style: TextStyle(fontSize: 28),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: Lottie.asset('assets/otp.json',
                                  repeat: false),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'An OTP will be sent to your phone number for verification',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      validator: (value) => (value == null || value.length < 10) 
                                        ? 'Invalid Phone Number' 
                                        : null,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      keyboardType: TextInputType.phone,
                                      decoration: textInputDecoration.copyWith(
                                        hintText: 'Phone number',
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          phoneNum = value;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: ()async{
                                      if(_formKey.currentState!.validate()){
                                        //int status = await AuthService().verifyPhone(phoneNum, context);
                                      }
                                    },
                                    // onPressed: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const OtpVerification(),
                                    //       ));
                                    // },
                                    child: const Text(
                                      'Verify Phone Number',
                                    ),
                                    //onPressed: ()async{
                                    //   final auth = GoogleAuthentication();
                                    //   setState(() {
                                    //     loading = true;
                                    //   });
                                    //   await auth.googleSignIn();
                                    //   setState(() {
                                    //     loading = false;
                                    //   });
                                    // },
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
