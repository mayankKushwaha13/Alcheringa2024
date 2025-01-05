import 'package:alcheringa/Screens/merch_buy_screen.dart';
import 'package:flutter/material.dart';

class MerchDetailScreen extends StatefulWidget {
    final String merchTitle;
  final String merchSubtitle;
  final String price;
  final String merchDescription;
  final String image;

    const MerchDetailScreen({
    Key? key,
    required this.merchTitle,
    required this.merchSubtitle,
    required this.price,
    required this.merchDescription,
    required this.image,
  }) : super(key: key);


  @override
  State<MerchDetailScreen> createState() => _MerchDetailScreenState();
}

class _MerchDetailScreenState extends State<MerchDetailScreen> {
  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    final List<int> lengths = [26, 27, 29, 29, 30];
  final List<int> chests = [40, 42, 44, 46, 48];
  int selectedIndex = 2;
  String selectedSize = "L"; 

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
    return Scaffold(
      backgroundColor: Color(0xFF1D2B53),
      body: SafeArea(
        child: Container(
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
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Ensures text alignment
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/back_button.png',
                          width: 54.0,
                          height: 54.0,
                        ),
                      ),
                      const Text(
                        'Merchandise',
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 119, 168, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Image.network(
                        widget.image,
                        width: 200,
                        ),
                      ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.merchTitle,
                    style: TextStyle(
                      fontFamily: 'AlcherPixelBold',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 241, 232, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.merchSubtitle,
                    style: const TextStyle(
                      fontFamily: 'AlcherPixel',
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
                    widget.price,
                    style: const TextStyle(
                      fontFamily: 'AlcherPixel',
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
                          fontFamily: 'AlcherPixel',
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
                            fontFamily: 'AlcherPixel',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: selectLeft,
                        child: Image.asset(
                          alignment: Alignment.topCenter,
                          'assets/images/product_detail_sprite.png',
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: sizes.asMap().entries.map((entry) {
                              final index = entry.key;
                              final size = entry.value;
                              final isSelected = index == selectedIndex;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  size,
                                  style: TextStyle(
                                    fontFamily: 'AlcherPixel',
                                    fontSize: isSelected ? 35 : 25,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Color.fromRGBO(255, 241, 232, 1)
                                        : Color.fromRGBO(131, 118, 156, 1),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Image.asset(
                            color: Color.fromRGBO(255, 119, 168, 1),
                            alignment: Alignment.topCenter,
                            'assets/images/scroll.png',
                            width: 250,
                            height: 3,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: selectRight,
                        child: Transform.rotate(
                          angle: 3.14159265359,
                          child: Image.asset(
                            alignment: Alignment.topCenter,
                            'assets/images/product_detail_sprite.png',
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  SizedBox(height: 10,),
        
                if (isSizeChartVisible)
                         Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Length (+/- 0.5 in):",
                      style: TextStyle(color: Color.fromRGBO(131, 118, 156, 1)),),
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
                          fontFamily: 'AlcherPixel',
                          fontSize: isSelected ? 20 : 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Color.fromRGBO(255, 241, 232, 1)
                              : Color.fromRGBO(131, 118, 156, 1),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Chest (+/- 0.5 in):",
                      style: TextStyle(color: Color.fromRGBO(131, 118, 156, 1)),),
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
                          fontFamily: 'AlcherPixel',
                          fontSize: isSelected ? 20 : 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? Color.fromRGBO(255, 241, 232, 1)
                              : Color.fromRGBO(131, 118, 156, 1),
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
                    widget.merchDescription,
                    style: const TextStyle(
                      fontFamily: 'AlcherPixel',
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
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MerchBuyScreen(
                  merchTitle: widget.merchTitle,
                  merchSubtitle: widget.merchSubtitle,
                  merchSize: selectedSize,
                  price: widget.price,
                  image: widget.image,
                ),
              ),
            );
                        },
                        child: Stack(
                          children: [
                            Image.asset(
                              alignment: Alignment.topCenter,
                              'assets/images/green_button.png',
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Buy now",
                                style: const TextStyle(
                                  fontFamily: 'AlcherPixel',
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(255, 241, 232, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            alignment: Alignment.topCenter,
                            'assets/images/sign_in.png',
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Add to cart",
                              style: const TextStyle(
                                fontFamily: 'AlcherPixel',
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(255, 241, 232, 1),
                              ),
                            ),
                          ),
                        ],
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
