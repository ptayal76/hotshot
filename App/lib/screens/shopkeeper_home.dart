import 'package:flutter/material.dart';
import 'package:hotshot/constants/constants.dart';

class ShopkeeperHome extends StatefulWidget {
  const ShopkeeperHome({super.key});

  @override
  State<ShopkeeperHome> createState() => _ShopkeeperHomeState();
}

class _ShopkeeperHomeState extends State<ShopkeeperHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Shop Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Location'),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              //   child: TextFormField(
              //     decoration: textInputDecoration.copyWith(
              //         hintText: 'Location Category'),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: InputDecorator(
                  decoration: textInputDecoration,
                  child: DropdownButton(
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(20),
                    isExpanded: true,
                    value: 'Khokha',
                    items: const [
                      DropdownMenuItem(
                        value: 'Khokha',
                        child: Text('Khokha'),
                      ),
                      DropdownMenuItem(
                        value: 'Campus',
                        child: Text('Campus'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Timings'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Type'),
                ),
              ),
            ],
          )),
    );
  }
}
