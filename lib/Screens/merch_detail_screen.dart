import 'package:alcheringa/Model/merchModel.dart';
import 'package:alcheringa/Screens/cart_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Database/DBHandler.dart';
import '../Model/cart_model.dart';
import '../provider/cart_provider.dart';
import '../utils/styles/colors.dart';

class MerchDetailScreen extends StatefulWidget {
  final MerchModel merch;

  const MerchDetailScreen({
    super.key,
    required this.merch,
  });

  @override
  State<MerchDetailScreen> createState() => _MerchDetailScreenState();
}

class _MerchDetailScreenState extends State<MerchDetailScreen> {
  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<int> lengths = [26, 27, 29, 29, 30];
  final List<int> chests = [40, 42, 44, 46, 48];
  final DBHandler dbHandler = DBHandler();
  int selectedIndex = 2;
  String selectedSize = "L";
  int currentIndex = 0;
  PageController pageController = PageController();

  bool isSizeChartVisible = false;

  void toggleSizeChart() {
    setState(() {
      isSizeChartVisible = !isSizeChartVisible;
    });
  }

  void selectLeft() {
    setState(() {
      if (selectedIndex > 0) selectedIndex--;
      selectedSize = sizes[selectedIndex];
    });
  }

  void selectRight() {
    setState(() {
      if (selectedIndex < sizes.length - 1) selectedIndex++;
      selectedSize = sizes[selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _appBar(context),
        // backgroundColor: Color(0xFF1D2B53),
        body: Container(
          padding: EdgeInsets.only(top: kToolbarHeight + 20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            // Added SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Ensures text alignment
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: 2,
                      onPageChanged: (newIndex) {},
                      itemBuilder: (BuildContext context, int index) {
                        return CachedNetworkImage(
                          imageUrl: widget.merch.images![index],
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: CustomizableEffect(
                      dotDecoration: DotDecoration(
                        color: Colors.grey,
                        width: 3,
                        height: 3
                      ),
                      activeDotDecoration: DotDecoration(
                        color: Colors.white,
                        width: 9,
                        height: 9
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.merch.type!,
                    style: TextStyle(
                      fontFamily: 'Brick_Pixel',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 241, 232, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.merch.name!,
                    style: const TextStyle(
                      fontFamily: 'Game_Tape',
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(255, 119, 168, 1),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Rs. ${widget.merch.price}',
                    style: const TextStyle(
                      fontFamily: 'Game_Tape',
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(255, 241, 232, 1),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PICK YOUR SIZE',
                        style: const TextStyle(
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 241, 232, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          toggleSizeChart();
                        },
                        child: Text(
                          'SIZE CHART',
                          style: const TextStyle(
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(255, 119, 168, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: selectLeft,
                        child: Image.asset(
                          'assets/images/product_detail_sprite.png',
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 3,),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: sizes.asMap().entries.map((entry) {
                                final index = entry.key;
                                final size = entry.value;
                                final isSelected = index == selectedIndex;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      selectedSize = size;
                                    });
                                  },
                                  child: Text(
                                    size,
                                    style: TextStyle(
                                      fontSize: isSelected ? 30 : 22,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected
                                          ? Color.fromRGBO(255, 241, 232, 1)
                                          : Color.fromRGBO(131, 118, 156, 1),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Image.asset(
                              'assets/images/scroll.png',
                              width: MediaQuery.of(context).size.width,
                              height: 3,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 3,),
                      GestureDetector(
                        onTap: selectRight,
                        child: Transform.rotate(
                          angle: 3.14159265359,
                          child: Image.asset(
                            'assets/images/product_detail_sprite.png',
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (isSizeChartVisible)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Length (+/- 0.5 in):",
                            style: TextStyle(color: Color.fromRGBO(131, 118, 156, 1)),
                          ),
                        ],
                      ),
                      // Length Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: sizes.asMap().entries.map((entry) {
                          final index = entry.key;
                          final length = lengths[index];
                          final isSelected = index == selectedIndex;
                          return Text(
                            length.toString(),
                            style: TextStyle(
                              fontFamily: 'Game_Tape',
                              fontSize: isSelected ? 20 : 16,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Color.fromRGBO(255, 241, 232, 1) : Color.fromRGBO(131, 118, 156, 1),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Chest (+/- 0.5 in):",
                            style: TextStyle(color: Color.fromRGBO(131, 118, 156, 1)),
                          ),
                        ],
                      ),
                      // Chest Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: sizes.asMap().entries.map((entry) {
                          final index = entry.key;
                          final chest = chests[index];
                          final isSelected = index == selectedIndex;
                          return Text(
                            chest.toString(),
                            style: TextStyle(
                              fontFamily: 'Game_Tape',
                              fontSize: isSelected ? 20 : 16,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Color.fromRGBO(255, 241, 232, 1) : Color.fromRGBO(131, 118, 156, 1),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    widget.merch.description!,
                    style: const TextStyle(
                      fontFamily: 'Game_Tape',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(255, 241, 232, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () async {
                            final cartItem = CartModel(
                              name: widget.merch.type!,
                              price: widget.merch.price!,
                              size: selectedSize,
                              count: "1",
                              // Default count
                              imageUrl: widget.merch.image!,
                              type: "Merchandise", // Type (optional)
                            );

                            await Provider.of<CartProvider>(context, listen: false).addItem(cartItem, context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                          },
                          child: Stack(
                            children: [
                              Image.asset(
                                alignment: Alignment.topCenter,
                                'assets/images/green_button.png',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text(
                                    "Buy now",
                                    style: const TextStyle(
                                        fontFamily: 'Brick_Pixel',
                                        fontSize: 23,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(255, 241, 232, 1),
                                        shadows: [
                                          Shadow(offset: Offset(2.5, 2), color: Colors.black),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: GestureDetector(
                          // Add this to the "Add to Cart" GestureDetector
                          onTap: () async {
                            // Add the selected merch to the cart
                            final cartItem = CartModel(
                              name: widget.merch.type!,
                              price: widget.merch.price!,
                              size: selectedSize,
                              count: "1",
                              // Default count
                              imageUrl: widget.merch.image!,
                              type: "Merchandise", // Type (optional)
                            );

                            await Provider.of<CartProvider>(context, listen: false).addItem(cartItem, context);

                            // Show confirmation
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Added ${widget.merch.type} to the cart!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },

                          child: Stack(
                            children: [
                              Image.asset(
                                alignment: Alignment.topCenter,
                                'assets/images/sign_in.png',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Text(
                                    "Add to cart",
                                    style: const TextStyle(
                                        fontFamily: 'Brick_Pixel',
                                        fontSize: 23,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(255, 241, 232, 1),
                                        shadows: [
                                          Shadow(offset: Offset(2.5, 2), color: Colors.black),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    toolbarHeight: kToolbarHeight + 20,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.black.withOpacity(.5),
    leading: Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(
          'assets/images/back_button.png',
          width: 54.0,
          height: 54.0,
        ),
      ),
    ),
    actions: [
      Padding(
          padding: EdgeInsets.only(bottom: 5, right: 20),
          child: Text(
            "Merchandize",
            style: TextStyle(color: AppColors.Pink, fontFamily: 'Game_Tape', fontSize: 24),
          ))
    ],
  );
}
