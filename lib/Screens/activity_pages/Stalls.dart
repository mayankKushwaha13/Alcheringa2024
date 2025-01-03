import 'package:alcheringa/Screens/end_drawer.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../cart_screen.dart';
import '../notification/notification_screen.dart';
import 'PixelStoreCardWidget.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({Key? key}) : super(key: key);

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();

}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final List<String> _restaurants = [
    'Magpie Junction',
    'Jai Ma Kamakhya',
    'Pizza Hut',
    'Mast Biryani',
    'Fat Belly',
    'Dominos',
    'KFC'
  ];
  List<String> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = List.from(_restaurants); // Initially, all restaurants are displayed.
}

  void _filterRestaurants(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredRestaurants = List.from(_restaurants);
      });
    } else {
      setState(() {
        _filteredRestaurants = _restaurants
            .where((restaurant) => restaurant.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: EndDrawer(scaffoldState: _scaffoldKey,),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 43, 83),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                  },
                  icon: Image.asset('assets/images/appbar_cart_icon.png'),
                ),
                badges.Badge(
                  badgeContent: Text(
                    '2',
                    style: TextStyle(
                      color: Color(0xFFCA3562),
                      fontFamily: 'Alcherpixel',
                    ),
                  ),
                  position: badges.BadgePosition.bottomEnd(bottom: 0, end: 10),
                  badgeStyle:
                  badges.BadgeStyle(badgeColor: Colors.transparent, borderRadius: BorderRadius.circular(5)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen()));
                    },
                    icon: Image.asset('assets/images/appbar_notification_icon.png'),
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/appbar_alcheringa.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // Action for first trailing icon
                  },
                  icon: Image.asset('assets/images/appbar_search_icon.png'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Image.asset(
              'assets/images/appbar_menu_icon.png',
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1A237E),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_alcher_app_25.png',
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          // Main Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.transparent, // Transparent container
              child: Column(
                children: [
                  Opacity(
                    opacity: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.0), // Transparent background
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('assets/images/eventsIcon.png'),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('assets/images/competitionsIcon.png'),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('assets/images/stallsNavigationIcon.png'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(

                            color: Color(0xff1d2b53),
                            child:
                            PixelTextField(controller: _searchController, onChanged: _filterRestaurants,)
                          )

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: PixelStoreCard(name: _filteredRestaurants[index] , ref: _filteredRestaurants[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PixelTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final double horizontalPdding;
  final double height;

  const PixelTextField({
    super.key,
    this.controller,
    this.hintText = 'Search Food',
    this.onChanged,
    this.keyboardType,
    this.horizontalPdding= 20.0,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (horizontalPdding * 2),
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/textField.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'AlcherpixelBold'
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xff83769c),
              fontFamily: 'AlcherpixelBold',
              fontSize: 22
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 8,
            ),
          ),
        ),
      ),
    );
  }
}