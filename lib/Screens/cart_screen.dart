import 'package:alcheringa/widgets/cart_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double total = 4250.0;

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
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/back_button.png',
                      width: 54.0,
                      height: 54.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/cart_title.png',
                      width: 40.0,
                      height: 25.0,
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
                  width: 300.0, // Set desired width
                  height: 50.0, // Set desired height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/total_price_cart.png'), // Path to your image
                      fit: BoxFit.cover, // Make the image cover the container
                    ),
                  ),
                ),
                Text(
                  'Hello, Flutter!', // Your text
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 24.0, // Text size
                    fontWeight: FontWeight.bold, // Optional: Bold text
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0), // Shadow position
                        blurRadius: 4.0, // Shadow blur
                        color: Colors.black, // Shadow color
                      ),
                    ],
                  ),
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
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 190.0, // Set desired width
                  height: 50.47, // Set desired height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/sign_in.png'), // Path to your image
                      fit: BoxFit.cover, // Make the image cover the container
                    ),
                  ),
                ),
                Text(
                  'Buy', // Your text
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 24.0, // Text size
                    fontWeight: FontWeight.bold, // Optional: Bold text
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0), // Shadow position
                        blurRadius: 4.0, // Shadow blur
                        color: Colors.black, // Shadow color
                      ),
                    ],
                  ),
                ),
              ],
            ), // Additional spacing
            // Additional content
          ],
        ),
      ),
    );
  }
}
