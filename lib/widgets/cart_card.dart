import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
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
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
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
              width: 100, // Fixed width
              height: 100, // Fixed height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    'Rs. ${widget.price}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    'Size: ${widget.size}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Left Arrow
                      GestureDetector(
                        onTap: () {
                          // Decrease quantity logic
                        },
                        child: Image.asset(
                          'assets/images/product_detail_sprite.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      // Quantity Box
                      Container(
                        width: 40.0,
                        height: 40.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          '${widget.quantity}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      // Right Arrow (Flipped)
                      GestureDetector(
                        onTap: () {
                          // Increase quantity logic
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

// import 'package:flutter/material.dart';
//
// class CartCard extends StatefulWidget {
//   final String title;
//   final String subtitle;
//   final double price;
//   final String size;
//   final String imageUrl;
//   final int quantity;
//
//   CartCard(
//       {required this.title,
//       required this.subtitle,
//       required this.price,
//       required this.size,
//       required this.imageUrl,
//       required this.quantity});
//
//   @override
//   State<CartCard> createState() => _CartCardState();
// }
//
// class _CartCardState extends State<CartCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 327,
//         height: 192,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/product_details.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 height: 120,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(widget.imageUrl),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 16.0),
//             Expanded(
//               flex: 3,
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.title,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       widget.subtitle,
//                       style: TextStyle(
//                         color: Colors.pinkAccent,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       '${widget.price}',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Size: ${widget.size}',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Image.asset(
//                           'assets/images/product_detail_sprite.png',
//                           width: 54.0,
//                           height: 54.0,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               border:
//                                   Border.all(color: Colors.black, width: 3)),
//                           child: Text(
//                             '${widget.quantity}',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16.0,
//                             ),
//                           ),
//                         ),
//                         Transform(
//                           transform: Matrix4.identity()
//                             ..scale(-1.0, 1.0), // Flip horizontally
//                           child: Image.asset(
//                             'assets/images/product_detail_sprite.png',
//                             width: 54.0,
//                             height: 54.0,
//                           ),
//                         ),
//                       ],
//                     )
//                   ]),
//             ),
//           ]),
//         ));
//   }
// }
