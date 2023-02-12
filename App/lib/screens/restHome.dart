import 'package:flutter/material.dart';
import 'package:hotshot/widgets/dishCard.dart';
import 'package:hotshot/widgets/restCard.dart';
import 'package:hotshot/widgets/sideDrawer.dart';

import '../model/dishInfo.dart';
import '../model/restHelper.dart';
import '../model/restInfo.dart';
import '../widgets/filters.dart';
import '../widgets/searchBar.dart';

class RestHome extends StatefulWidget {
  RestHome({Key? key}) : super(key: key);
  final List<RestInfo> topPicks = RestHelper.topPicks;
  final List<DishInfo> suggested = RestHelper.suggested;
  @override
  State<RestHome> createState() => _RestHomeState();
}

class _RestHomeState extends State<RestHome>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
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
                  });
                },
                labelColor: Colors.white,
                unselectedLabelColor: Colors.blueGrey,
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
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[

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
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart),
                tooltip: 'Cart',
              )
            ],
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                SearchBar(),
                Filters(),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Top Picks',
                    style: TextStyle(
                      color: Colors.black,
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
                        return RestCard(data: widget.topPicks[index]);
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
                            'Suggested',
                            style: TextStyle(
                              color: Colors.black,
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
                                return DishCard(data: widget.suggested[index]);
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
                        // SliverList(
                        //     delegate: SliverChildBuilderDelegate((context,index){
                        //       return RestCard(data: widget.topPicks[index]);
                        //     },
                        //     childCount: widget.topPicks.length,
                        //     )
                        // ),

                      ]
                  ),
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
                            'Restaurants',
                            style: TextStyle(
                              color: Colors.black,
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
                              return RestCard(data: widget.topPicks[index]);
                            },
                            shrinkWrap: true,
                            //scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: widget.topPicks.length),
                      ]
                  ),
                )
              ]
            ),
          // physics: BouncingScrollPhysics(),
          // children: [
          //
          //
          // ],
        ),
        ]
      ),
    );
  }
}
