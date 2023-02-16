import 'package:flutter/material.dart';
import 'package:hotshot/services/restaurantServ.dart';
import 'package:hotshot/widgets/dishCard.dart';
import 'package:hotshot/widgets/restCard.dart';
import 'package:hotshot/screens/statHome.dart';
import 'package:hotshot/screens/otherHome.dart';
import 'package:hotshot/widgets/sideDrawer.dart';
// import 'package:mongo_dart/mongo_dart.dart' hide State;
// import '../constants/globvar.dart';
import '../constants/globvar.dart';
import '../screens/cart.dart';
import '../constants/loader.dart';
import '../model/dishInfo.dart';
import '../model/restHelper.dart';
import 'package:badges/badges.dart' as badges;
import '../model/restInfo.dart';
import '../widgets/filters.dart';
import '../widgets/searchBar.dart';
// late var restaurants=[];

class RestHome extends StatefulWidget {
  RestHome({Key? key}) : super(key: key);
  // final List<RestInfo> topPicks = RestHelper.topPicks;
  // final List<DishInfo> suggested = RestHelper.suggested;
  @override
  State<RestHome> createState() => _RestHomeState();
}



class _RestHomeState extends State<RestHome>
    with SingleTickerProviderStateMixin {
  List<RestInfo>? restaur;
  final RestaurantServ restServ = RestaurantServ();
  fetchallrest() async {
    restaur=await restServ.fetchAllRestaurants(context);
    for(int i=0;i<restaur!.length;i++){
      allRest![restaur![i].id]=restaur![i];

    }
    setState(() {

    });
  }
  int _selectedIndex = 0;
  // Future<void> Mongo() async{
  //   var db=await Db.create("mongodb+srv://lohit:lohit2105@hotshot-cluster.vljarxr.mongodb.net/?retryWrites=true&w=majority");
  //   await db.open();
  //   var coll=db.collection('restaurants');
  //   restaurants = await coll.find().toList();
  //   print (restaurants);
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
        margin: const EdgeInsets.all(8),
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
            Text(label, style: const TextStyle(fontSize: 8)),
          ],
        ));
  }

  late TabController _tabController;
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallrest();
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
      drawer: NavigationDrawerWidget(),
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
                    if(x == 2)
                    {
                      Navigator.pushReplacement(context,
                          new MaterialPageRoute(builder: (BuildContext context) => OtherHome())
                      );
                    }
                    else if(x == 1)
                    {
                      Navigator.pushReplacement(context,
                          new MaterialPageRoute(builder: (BuildContext context) => StatHome())
                      );
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
                      isSelected: i == _selectedIndex,
                    ),
                ],
                controller: _tabController),
          ),
        ),
      ),
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: <
          Widget>[
        SliverAppBar(
          pinned: true,
          floating: true,
          // expandedHeight: 100,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('HotShot'),
            centerTitle: true,
          ),
          backgroundColor: const Color(0xff307A59),
          //pinned: false,
          //floating: false,
          actions: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: 3, end: 3),
              badgeContent: Text(''),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) => cart())
                  );
                },

                icon: Icon(Icons.shopping_cart),
                //alignment: Alignment(x, y),
                tooltip: 'Cart',
              ),
            )
          ],
        ),
        restaur==null ? SliverToBoxAdapter(child: Loader()):SliverList(
          delegate: SliverChildListDelegate([
            const SearchBar(),
            Filters(),
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                'Top Picks',
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
                        return RestCard(data: restaur![index]);
                      },
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 16,
                        );
                      },
                      itemCount: restaur!.length),
                ),
                // Container(
                //   child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           margin: EdgeInsets.only(top: 12),
                //           padding: EdgeInsets.symmetric(horizontal: 16),
                //           width: MediaQuery.of(context).size.width,
                //           child: Text(
                //             'Suggested',
                //             style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 18,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ),
                //         ),
                //         Container(
                //           margin: EdgeInsets.only(top: 12),
                //           height: 150,
                //           child: ListView.separated(
                //               padding: EdgeInsets.symmetric(horizontal: 16),
                //               itemBuilder: (context, index) {
                //                 return DishCard(data: widget.suggested[index]);
                //               },
                //               physics: BouncingScrollPhysics(),
                //               shrinkWrap: true,
                //               scrollDirection: Axis.horizontal,
                //               separatorBuilder: (context, index) {
                //                 return SizedBox(
                //                   width: 16,
                //                 );
                //               },
                //               itemCount: widget.topPicks.length),
                //         ),
                //         // SliverList(
                //         //     delegate: SliverChildBuilderDelegate((context,index){
                //         //       return RestCard(data: widget.topPicks[index]);
                //         //     },
                //         //     childCount: widget.topPicks.length,
                //         //     )
                //         // ),
                //
                //       ]
                //   ),
                // ),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Restaurants',
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                              return RestCard(data: restaur![index]);
                            },
                            shrinkWrap: true,
                            //scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: restaur!.length),
                      ]
                  ),
                )
            //   ]
            //   ),
            // ),

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
