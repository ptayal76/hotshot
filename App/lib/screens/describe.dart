import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import '../model/restInfo.dart';
import '../model/otherInfo.dart';
class describe extends StatefulWidget {
  const describe({Key? key, required this.data}) : super(key: key);
final OtherInfo data;
  @override
  State<describe> createState() => _describeState();
}

class _describeState extends State<describe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(backgroundColor: const Color(0xff307A59),title: Text(widget.data.restaurantName),),
    body: CustomScrollView(
    physics: BouncingScrollPhysics(),
      slivers: <Widget>[

      SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.data.shopName),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff307A59),

    ),
    SliverList(
    delegate: SliverChildListDelegate(
    [
      Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.green[100],
              borderRadius: BorderRadius.circular(30.0),
          ),

          child: Image.asset(widget.data.pic,fit: BoxFit.fill),
        ),
      ),
      SizedBox(height: 5,),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                IconButton(icon: const Icon(Icons.call),onPressed: () {}
                ),
              Text('Call'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(Icons.email),
                Text('email'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(Icons.pin_drop_rounded),
                Text('location'),
              ],
            ),
          ),
        ],
      ),
      Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xff307A59),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [Text('Owner Name: ${widget.data.ownerName}',style: const TextStyle(color: Colors.white,fontSize: 20),),],
        ),
      ),
      SizedBox(height: 5,),
      Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xff307A59),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [Text('Email Id: ${widget.data.email}',style: const TextStyle(color: Colors.white,fontSize: 20))],
        ),
      ),
      SizedBox(height: 5,),
      Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xff307A59),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [Text('Contact Info: ${widget.data.phoneNumber}',style: const TextStyle(color: Colors.white,fontSize: 20))],
        ),
      ),
      SizedBox(height: 5,),
      Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xff307A59),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [Text('Location : ${widget.data.category}',style: TextStyle(color: Colors.white,fontSize: 20))],
        ),
      ),
      SizedBox(height: 5,),
      Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xff307A59),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [Text((widget.data.status == 'on')? 'Status: Open Now' : 'Status: Closed Now',style: TextStyle(color: Colors.white,fontSize: 20))],
        ),
      ),
      SizedBox(height: 5,),
      Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xff307A59),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [Text('Description:',style: TextStyle(color: Colors.white,fontSize: 20))],
        ),
      ),
      SizedBox(height: 5,),

      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.maxFinite,
            height:200,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(30)
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.data.description,style: const TextStyle( fontSize: 20,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),),
            ),

          ),
        ),
      )
      ],
    )
    )
    ]
    )
    );
  }
}
