import 'package:flutter/material.dart';
import 'package:hotshot/widgets/menuCard.dart';
import 'package:lottie/lottie.dart';
// import 'package:hotshot/model/checkInfo.dart';
// import 'package:hotshot/model/checkHelper.dart';

class feedback extends StatefulWidget {
  const feedback({Key? key}) : super(key: key);

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Feedback'),
        backgroundColor: const Color.fromARGB(255, 239, 102, 105),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('assets/lottie/feedback.json',fit: BoxFit.fill),
              Text('Tell us what you love about the app,or what we could be doing better.'),
              SizedBox(height: 12,),
              TextField(decoration: InputDecoration(hintText: 'Enter Feedback',hintStyle: TextStyle(fontSize: 25),))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: new GestureDetector(
          onTap: (){
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Thanks for your valuable feedback!',style: TextStyle(fontSize: 15),)
              ));
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (BuildContext context) => feedback())
              );



            });

          },
          child: Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 102, 105),
                borderRadius: BorderRadius.circular(15.0)
              ),
             
              child: Center(child: Text('Submit Feedback',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
            ),
          ),
        ),
      ),


    );
  }
}
