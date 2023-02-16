import 'package:flutter/material.dart';
import 'package:hotshot/model/dishInfo.dart';
import 'package:hotshot/services/restaurantServ.dart';

class DishFromID extends StatefulWidget {
  final List<String> data;
  final BuildContext context;
  const DishFromID({Key? key, required this.context, required this.data})
      : super(key: key);

  @override
  State<DishFromID> createState() => _DishFromIDState();
}

List<DishInfo> Dinfo = [];
final RestaurantServ restServ = RestaurantServ();
final List<String> name = [];

class _DishFromIDState extends State<DishFromID> {
  fetchalldish(List<String> data) async {
    Dinfo = await restServ.fetchDish(context, data);
    for (int i = 0; i < Dinfo.length; i++) {
      name[i] = Dinfo[i].name!;
    }
    setState(() {});
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchalldish(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Order Items: ${name}',
      style: const TextStyle(fontSize: 20),
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// final RestaurantServ restServ = RestaurantServ();
// List<String> names = [];
// Future<List<String>> DishFromDishID(
//     BuildContext context, List<String> data) async {
//   Dinfo = await restServ.fetchDish(context, data);
//   for (int i = 0; i < Dinfo.length; i++) {
//     names[i] = Dinfo[i].name!;
//   }
//   return names;
// }
