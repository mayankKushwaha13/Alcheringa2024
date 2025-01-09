import 'package:flutter/material.dart';

class MerchBuyScreen extends StatefulWidget {
  final String merchTitle;
  final String merchSubtitle;
  final String price;
  final String merchSize;
  final String image;

  const MerchBuyScreen({
    Key? key,
    required this.merchTitle,
    required this.merchSubtitle,
    required this.price,
    required this.merchSize,
    required this.image,
  }) : super(key: key);

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
                        fontFamily: 'Game_Tape',
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
                          width: 330,
                          fit: BoxFit.cover,
                        ),
                        // Positioned Text
                        Positioned.fill(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Ensures the column doesn't take extra space
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Ensures text is centered
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Rs. ${widget.price}',
                                        style: const TextStyle(
                                          fontFamily: 'Game_Tape',
                                          fontSize: 30,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(255, 241, 232, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign
                                      .center, // Ensures center alignment
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Total: 5 items",
                                        style: const TextStyle(
                                          fontFamily: 'Game_Tape',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(255, 241, 232, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign
                                      .center, // Ensures center alignment
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Stack(
                        children: [
                          Image.asset(
                            alignment: Alignment.topCenter,
                            'assets/images/product_details.png',
                            width: 400,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        widget.image,
                                        width: 120,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      widget.merchTitle,
                                      style: TextStyle(
                                        fontFamily: 'Game_Tape',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(255, 241, 232, 1),
                                      ),
                                    ),
                                    Text(
                                      widget.merchSubtitle,
                                      style: TextStyle(
                                        fontFamily: 'Game_Tape',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(255, 119, 168, 1),
                                      ),
                                    ),
                                    Text(
                                      'Rs. ${widget.price}/-',
                                      style: TextStyle(
                                        fontFamily: 'Game_Tape',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(255, 241, 232, 1),
                                      ),
                                    ),
                                    Text(
                                      'Size: ${widget.merchSize}',
                                      style: TextStyle(
                                        fontFamily: 'Game_Tape',
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
                                              widget.merchSize,
                                              style: TextStyle(
                                                fontFamily: 'Game_Tape',
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
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400,
                    ),
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
                                fontFamily: 'Game_Tape',
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
