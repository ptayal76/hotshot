import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VerificationPending extends StatelessWidget {
  const VerificationPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HotShot'),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: double.maxFinite,
              child: Lottie.asset(
                'assets/waiting.json',
              ),
            ),
            const SizedBox(height: 30,),
            Card(
              elevation: 1,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Text(
                  'Physical verification of your shop is still pending. Please check after some time.\nYou\'ll be able to add any further details after physical verification only.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}