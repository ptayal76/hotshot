import 'package:flutter/material.dart';
import 'package:hotshot/model/orders.dart';

class OrderCard extends StatefulWidget {
  final Orders data;
  const OrderCard({Key? key,required this.data}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Column(
              children: [
                  Text(
                    widget.data.restaurant_id,
                    style:TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // ListView.builder(itemBuilder: (context,index){
                  //   widget.data.items.forEach((key, value) {Text('$key: $value')});
                  // )
                for(var element in widget.data.items.entries)
                  ListTile(
                    title: Text(element.key +": "+"${element.value}"),
                  )


              ],
            )),
            IconButton(onPressed: (){}, icon: Icon(Icons.navigate_next_outlined))
          ],
        ),
      ),


    );
  }
}
