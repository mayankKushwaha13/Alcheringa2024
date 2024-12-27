import 'package:flutter/material.dart';

class MerchBuyScreen extends StatefulWidget {
  const MerchBuyScreen({super.key});

  @override
  State<MerchBuyScreen> createState() => _MerchBuyScreenState();
}

class _MerchBuyScreenState extends State<MerchBuyScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        // Background Image
                        Image.asset(
                          scale: 5.0,
                          alignment: Alignment.topCenter,
                          'assets/images/total_price_cart.png',
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        // Positioned Text
                        Positioned.fill(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Rs. 4250\n",
                                    style: const TextStyle(
                                      fontFamily: 'AlcherPixel',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(255, 241, 232, 1),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Total: 5 items",
                                    style: const TextStyle(
                                      fontFamily: 'AlcherPixel',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(255, 241, 232, 1),
                                    ),
                                  ),
                                ],
                              ),
                              textAlign:
                                  TextAlign.center, // Ensures center alignment
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Stack(
                        children: [
                          Image.asset(
                            alignment: Alignment.topCenter,
                            'assets/images/3.png',
                            width: 350,
                            fit: BoxFit.cover,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 200,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'SWEATSHIRT',
                                    style: TextStyle(
                                      fontFamily: 'AlcherPixel',
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(255, 241, 232, 1),
                                    ),
                                  ),
                                  Text(
                                    'CRAZY EYES',
                                    style: TextStyle(
                                      fontFamily: 'AlcherPixel',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(255, 119, 168, 1),
                                    ),
                                  ),
                                  Text(
                                    'Rs. 850 /-',
                                    style: TextStyle(
                                      fontFamily: 'AlcherPixel',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(255, 241, 232, 1),
                                    ),
                                  ),
                                  Text(
                                    'Size: L',
                                    style: TextStyle(
                                      fontFamily: 'AlcherPixel',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(255, 241, 232, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        alignment: Alignment.topCenter,
                                        'assets/images/product_detail_sprite.png',
                                        width: 40,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Color.fromRGBO(29, 43, 83, 1),
                                            width: 2.0,
                                          ),
                                          color: Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'S',
                                            style: TextStyle(
                                              fontFamily: 'AlcherPixel',
                                              fontSize: 30,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  255, 119, 168, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Transform.rotate(
                                        angle: 3.14159265359,
                                        child: Image.asset(
                                          alignment: Alignment.topCenter,
                                          'assets/images/product_detail_sprite.png',
                                          width: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 400,),
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            alignment: Alignment.topCenter,
                            'assets/images/sign_in.png',
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Buy",
                              style: const TextStyle(
                                fontFamily: 'AlcherPixel',
                                fontSize: 40,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(255, 241, 232, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
