import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final String size;
  final String imageUrl;
  final int quantity;

  CartCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.size,
    required this.imageUrl,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Container(
      width: 327,
      height: 192, // Fixed height to avoid render flow error
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/product_details.png'),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            Container(
              width: 126, // Fixed width
              height: 170, // Fixed height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            SizedBox(width: 16.0), // Space between image and details

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Game_Tape',
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Game_Tape',
                      color: Color.fromRGBO(255, 119, 168, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Rs. ${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: 'Game_Tape',
                      color: Color.fromRGBO(255, 241, 232, 1),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Size: $size',
                    style: TextStyle(
                      fontFamily: 'Game_Tape',
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Decrease Quantity Button
                      GestureDetector(
                        onTap: () {
                          if (quantity > 1) {
                            cartProvider.updateItemCount(
                              title,
                              size,
                              quantity - 1,
                            );
                          } else {
                            //cartProvider.removeItem(title, size);
                          }
                        },
                        child: Image.asset(
                          'assets/images/product_detail_sprite.png',
                          width: 40,
                          height: 40,
                        ),
                      ),

                      // Quantity Box
                      Container(
                        width: 53.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3.0),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '$quantity',
                            style: TextStyle(
                              fontFamily: 'Brick_Pixel',
                              color: Color.fromRGBO(255, 119, 168, 1),
                              fontSize: 60.0,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      // Increase Quantity Button
                      GestureDetector(
                        onTap: () {
                          cartProvider.updateItemCount(
                            title,
                            size,
                            quantity + 1,
                          );
                        },
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..scale(-1.0, 1.0),
                          child: Image.asset(
                            'assets/images/product_detail_sprite.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
