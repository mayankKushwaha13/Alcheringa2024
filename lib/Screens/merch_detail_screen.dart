import 'package:flutter/material.dart';

class MerchDetailScreen extends StatefulWidget {
    final String merchName;
  final String merchDescription;
  final String price;

    const MerchDetailScreen({
    Key? key,
    required this.merchName,
    required this.merchDescription,
    required this.price,
  }) : super(key: key);


  @override
  State<MerchDetailScreen> createState() => _MerchDetailScreenState();
}

class _MerchDetailScreenState extends State<MerchDetailScreen> {
  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  int selectedIndex = 2;

  void selectLeft() {
    setState(() {
      if (selectedIndex > 0) selectedIndex--;
    });
  }

  void selectRight() {
    setState(() {
      if (selectedIndex < sizes.length - 1) selectedIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              SizedBox(height: 250),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  widget.merchName,
                  style: TextStyle(
                    fontFamily: 'AlcherPixel',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 241, 232, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  widget.merchDescription,
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
                    Text(
                      'SIZE CHART',
                      style: const TextStyle(
                        fontFamily: 'AlcherPixel',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 119, 168, 1),
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
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                  "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor "
                  "in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
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
                    Stack(
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
    );
  }
}
