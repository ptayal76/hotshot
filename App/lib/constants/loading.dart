import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ),
        elevation: 1,
        title: const Text('Managr'),
      ),
      body: const Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}