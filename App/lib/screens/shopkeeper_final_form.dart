import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hotshot/services/google_auth.dart';

class ShopkeeperFinalForm extends StatefulWidget {
  const ShopkeeperFinalForm({super.key});

  @override
  State<ShopkeeperFinalForm> createState() => _ShopkeeperFinalFormState();
}

class _ShopkeeperFinalFormState extends State<ShopkeeperFinalForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleAuthentication().googleLogout();
              },
              icon: const Icon(Icons.logout))
        ],
        elevation: 1,
        title: const Text('HotShot'),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 1,
        height: 65,
        destinations: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 18),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: FilledButton(
                onPressed: () async {},
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ],
      ),
    );
  }
}