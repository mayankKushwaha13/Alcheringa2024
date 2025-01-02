import 'package:alcheringa/Screens/checkout_pages/checkout_page.dart';
import 'package:alcheringa/widgets/cart_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202F5A),
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
          child: Column(
            children: [
              // Semi-transparent header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color:
                      Colors.black.withOpacity(0.5), // Header background opacity
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
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Cart',
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 119, 168, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Space between header and body content
            
              // Stack with text and background image
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 246.0, // Set desired width
                    height: 54.0, // Set desired height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/total_price_cart.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Align texts vertically in the center
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center the texts horizontally
                    mainAxisSize: MainAxisSize
                        .min, // Makes the column take the minimum space
                    children: [
                      Text(
                        'Rs. 69', // Your text
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          color: Colors.white, // Text color
                          fontSize: 32.0, // Text size
                          fontWeight: FontWeight.w400,
                          height: 0.9, // Optional: Bold text
                        ),
                      ),
                      Text(
                        'Total: 5 items', // Your text
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          color: Colors.white, // Text color
                          fontSize: 16.0, // Text size
                          fontWeight: FontWeight.w400,
                          // Optional: Bold text
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            
              SizedBox(height: 20.0),
              CartCard(
                  title: 'Sweatshirt',
                  subtitle: 'crazy eyes',
                  price: 78.00,
                  size: 'L',
                  imageUrl: 'https://picsum.photos/seed/picsum/200/300',
                  quantity: 5),
              SizedBox(height: 20.0),
            
              // Spacer to push the Buy button to the bottom
              Spacer(),
            
              // "Buy" button at the bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CheckoutPage()));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 190.0, // Set desired width
                        height: 50.47, // Set desired height
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/sign_in.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Buy', // Your text
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          color: Colors.white, // Text color
                          fontSize: 36.0, // Text size
                          fontWeight: FontWeight.w400, // Optional: Bold text
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
