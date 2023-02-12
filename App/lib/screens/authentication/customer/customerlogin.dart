import 'package:flutter/material.dart';
import 'package:hotshot/constants/colors.dart';
import 'package:hotshot/constants/text.dart';
import 'package:lottie/lottie.dart';

String? name, imageUrl, email;

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],

      // appBar: AppBar(
      //   title: Text("Rasesh", style: GoogleFonts.breeSerif()),
      // ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            height: 340,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/droppedImage.jpg'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Container(
                height: 10,
                width: 10,
                child: Lottie.asset('assets/lottie_login.json',
                    alignment: Alignment.bottomCenter),
              ),
            ),
          ),
          const modified_text(
              text: 'Welcome to HotShot', color: blackColor, size: 35),
          const modified_text(
              text: 'Your OneStop solution for everything',
              color: blackColor,
              size: 25),
          const SizedBox(height: 50),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(300, 80), // (width,height)
                  textStyle: const TextStyle(fontSize: 28),
                  backgroundColor: greenColor,
                  foregroundColor: blackColor,
                ),
                child: const Text(
                  'Login with Google',
                  style: TextStyle(letterSpacing: 2),
                ),
                onPressed: () {}

                //   Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                // }
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(children: const <Widget>[
            SizedBox(width: 30),
            Expanded(
                child: Divider(
              color: blackColor,
              thickness: 2,
            )),
            SizedBox(
              width: 5,
            ),
            Text(
              "OR",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Divider(
                color: blackColor,
                thickness: 2,
              ),
            ),
            SizedBox(width: 30),
          ]),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(300, 80), // (width,height)
                  textStyle: const TextStyle(fontSize: 28),
                  backgroundColor: whiteColor,
                  foregroundColor: blackColor,
                ),
                child: const Text(
                  'Login with Outlook',
                  style: TextStyle(letterSpacing: 2),
                ),
                onPressed: () {}
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                // }
                ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: modified_text(
                  text: 'Let\'s Get Started ->', color: blackColor, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
