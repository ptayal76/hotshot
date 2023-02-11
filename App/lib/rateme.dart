import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateMe extends StatefulWidget {
  const RateMe({super.key});

  @override
  State<RateMe> createState() => _RateMeState();
}

class _RateMeState extends State<RateMe> {
  var rating=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Center(child: Text("Give your review",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w500),)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 172),
            child: Container(
              child: RatingBar(
   initialRating: 3,
   direction: Axis.horizontal,
   allowHalfRating: false,
   itemCount: 5,
   ratingWidget: RatingWidget(
     full: Icon(Icons.star,color: Colors.amber,),
     half: Icon(Icons.star_half,color: Colors.amber),
     empty: Icon(Icons.star_border,color: Colors.amber),
   ),
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   onRatingUpdate: (rating) {
     print(rating);
   },
),
            ),
          ),
          Builder(
            builder: (context) {
              return ElevatedButton(onPressed: () {
                Navigator.of(context).pop(true);
              }, child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 64.0),
                child: Text("Submit",style: TextStyle(fontSize: 20)),
              ),
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
              );
            }
          )
        ],
      ),
    );
  }
}