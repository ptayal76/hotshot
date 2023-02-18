import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class RateMe extends StatefulWidget {
  const RateMe({super.key});

  @override
  State<RateMe> createState() => _RateMeState();
}

class _RateMeState extends State<RateMe> {
  var rating = 0.0;
  var rat = 0.0;
  List x = [0.0, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 102, 105),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Center(
                  child: Text(
                "Rate Your Experience",
                style: GoogleFonts.balooThambi2(
                  // color: color,
                  fontSize: 30,
                ),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Lottie.asset('assets/lottie/Ratinglottie.json',
                fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Your ratings and reviews helps people in going a long way in deciding where to go.",
              textAlign: TextAlign.center,
              style: GoogleFonts.balooThambi2(
                // color: color,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 32),
            child: Container(
              child: RatingBar(
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: const Icon(Icons.star_half, color: Colors.amber),
                  empty: const Icon(Icons.star_border, color: Colors.amber),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  print(rating);
                  x[0] = rating;
                },
              ),
            ),
          ),
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(x);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 102, 105),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.0),
                    child: Text("Submit", style: TextStyle(fontSize: 25)),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
