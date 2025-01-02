import 'package:alcheringa/Screens/checkout_pages/EventButton.dart';
import 'package:flutter/material.dart';

import 'PixelStoreCardWidget.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({Key? key}) : super(key: key);

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();

}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
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
      appBar: AppBar(
        title: const Text(
          "Merch",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.account_circle_outlined),
          )
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