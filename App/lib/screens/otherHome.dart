import 'package:flutter/material.dart';
import 'package:hotshot/widgets/dishCard.dart';
import 'package:hotshot/widgets/my_drawer.dart';
import 'package:hotshot/widgets/otherHelper.dart';
import 'package:hotshot/screens/checkout.dart';
import 'package:hotshot/screens/cart.dart';
import 'package:hotshot/widgets/restCard.dart';
import 'package:hotshot/widgets/sideDrawer.dart';
import 'package:hotshot/screens/restHome.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hotshot/screens/statHome.dart';
import '../widgets/otherCard.dart';
import '../model/dishInfo.dart';
import '../model/otherInfo.dart';
import '../model/restHelper.dart';
import '../model/restInfo.dart';
import '../model/otherInfo.dart';
import '../widgets/filters.dart';
import '../widgets/searchBar.dart';

class OtherHome extends StatefulWidget {
  OtherHome({Key? key}) : super(key: key);
  final List<OtherInfo> topPicks = OtherHelper.topPicks;
  final List<OtherInfo> suggested = OtherHelper.suggested;
  final List<OtherInfo> hospital = OtherHelper.hospital;
  @override
  State<OtherHome> createState() => _OtherHomeState();
}

class _OtherHomeState extends State<OtherHome>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
        margin: EdgeInsets.all(8),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 500),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff307A59),
              ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            child,
            Text(label, style: TextStyle(fontSize: 8)),
          ],
        ));
  }

  late TabController _tabController;
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  final List<String> _labels = ['Foods', 'Stationary', 'Others'];
  @override
  Widget build(BuildContext context) {
    List<Widget> _icons = const [
      Icon(Icons.fastfood),
      Icon(Icons.print),
      Icon(Icons.list_outlined)
    ];
    return Scaffold(
      // appBar: AppBar(
      //
      // ),
      drawer: MyDrawer(),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            color: Colors.green.withOpacity(0.2),
            child: TabBar(
                onTap: (x) {
                  setState(() {
                    _selectedIndex = x;
                    if (x == 0) {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => RestHome()));
                    } else if (x == 1) {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => StatHome()));
                    }
                  });
                },
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide.none,
                ),
                tabs: [
                  for (int i = 0; i < _icons.length; i++)
                    _tabItem(
                      _icons[i],
                      _labels[i],
                      isSelected: i == 2,
                    ),
                ],

                // labelColor: Colors.orange,
                controller: _tabController),
          ),
        ),
      ),
      body:
          CustomScrollView(physics: BouncingScrollPhysics(), slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('HotShot'),
            centerTitle: true,
          ),
          backgroundColor: Color(0xff307A59),
          //pinned: false,
          //floating: false,
          actions: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: 3, end: 3),
              badgeContent: Text(''),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => cart()));
                },

                icon: Icon(Icons.shopping_cart),
                //alignment: Alignment(x, y),
                tooltip: 'Cart',
              ),
            )
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //if(widget.hospital.length == 0)

                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Hospital',
                        style: TextStyle(
                          // color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // SliverList(
                    //     delegate: SliverChildBuilderDelegate((context,index){
                    //       return RestCard(data: widget.topPicks[index]);
                    //     },
                    //     childCount: widget.topPicks.length,
                    //     )
                    // ),
                    ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          return OtherCard(data: widget.hospital[index]);
                        },
                        shrinkWrap: true,
                        //scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: widget.hospital.length),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Rentals',
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 150,
              child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return OtherCard(data: widget.topPicks[index]);
                  },
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 16,
                    );
                  },
                  itemCount: widget.topPicks.length),
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Cycle Repair',
                        style: TextStyle(
                          // color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      height: 150,
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            return OtherCard(data: widget.suggested[index]);
                          },
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 16,
                            );
                          },
                          itemCount: widget.topPicks.length),
                    ),
                  ]),
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Souvenir',
                        style: TextStyle(
                          // color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      height: 150,
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            return OtherCard(data: widget.suggested[index]);
                          },
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 16,
                            );
                          },
                          itemCount: widget.topPicks.length),
                    ),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Mobile Repair',
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              height: 150,
                              child: ListView.separated(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  itemBuilder: (context, index) {
                                    return OtherCard(
                                        data: widget.suggested[index]);
                                  },
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 16,
                                    );
                                  },
                                  itemCount: widget.topPicks.length),
                            ),
                          ]),
                    ),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                'Barber',
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              height: 150,
                              child: ListView.separated(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  itemBuilder: (context, index) {
                                    return OtherCard(
                                        data: widget.suggested[index]);
                                  },
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 16,
                                    );
                                  },
                                  itemCount: widget.topPicks.length),
                            ),
                          ]),
                    ),
                  ]),
            ),
          ]),
          // physics: BouncingScrollPhysics(),
          // children: [
          //
          //
          // ],
        ),
      ]),
    );
  }
}
