import 'package:alcheringa/Screens/checkout_pages/checkout_page.dart';
import 'package:alcheringa/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(
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
                  color: Colors.black
                      .withOpacity(0.5), // Header background opacity
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
                          fontFamily: 'Game_Tape',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 119, 168, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              // Stack with total price and total items
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 246.0,
                    height: 54.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/total_price_cart.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Rs. ${cartProvider.totalPrice.toStringAsFixed(2)}', // Use CartProvider for total price
                        style: TextStyle(
                          fontFamily: 'Game_Tape',
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w400,
                          height: 0.9,
                        ),
                      ),
                      Text(
                        'Total: ${cartProvider.totalItems} items', // Use CartProvider for total items
                        style: TextStyle(
                          fontFamily: 'Game_Tape',
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.0),

              // Cart Items List
              Expanded(
                child: cartProvider.cartItems.isEmpty
                    ? Center(
                        child: Text(
                          "Your cart is empty!",
                          style: TextStyle(
                            fontFamily: 'Game_Tape',
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartProvider.cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CartCard(
                              title: item.name,
                              subtitle: item.type,
                              price: double.parse(item.price),
                              size: item.size,
                              imageUrl: item.imageUrl,
                              quantity: int.parse(item.count),
                            ),
                          );
                        },
                      ),
              ),

              // "Buy" button at the bottom
              GestureDetector(
                onTap: () {
                  if (cartProvider.cartItems.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Cart Is Empty! Nothing to purchase.")),);
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 190.0,
                        height: 50.47,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/sign_in.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Purchase',
                      style: TextStyle(
                        fontFamily: 'Brick_Pixel',
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
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

//
// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   final DBHandler dbHandler = DBHandler();
//   List<CartModel> cartItems = [];
//   double totalPrice = 0.0;
//   int totalItems = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCartItems();
//   }
//
//   Future<void> fetchCartItems() async {
//     final items = await dbHandler.readCourses();
//     setState(() {
//       cartItems = items;
//       calculateTotals(); // Calculate totals whenever items are fetched
//     });
//   }
//
//   Future<void> updateItemCount(String name, String size, int newCount) async {
//     await dbHandler.updateItemCount(
//         name, size, newCount.toString()); // Update count in DB
//     await fetchCartItems(); // Refresh cart
//   }
//
//   void calculateTotals() {
//     double price = 0.0;
//     int items = 0;
//
//     for (var item in cartItems) {
//       double itemPrice = double.parse(item.price);
//       int itemCount = int.parse(item.count);
//
//       price += itemPrice * itemCount; // Accumulate total price
//       items += itemCount; // Accumulate total items
//     }
//
//     setState(() {
//       totalPrice = price;
//       totalItems = items;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: [
//             // Semi-transparent header
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//               decoration: BoxDecoration(
//                 color:
//                     Colors.black.withOpacity(0.5), // Header background opacity
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Image.asset(
//                       'assets/images/back_button.png',
//                       width: 54.0,
//                       height: 54.0,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       'Cart',
//                       style: TextStyle(
//                         fontFamily: 'Game_Tape',
//                         fontSize: 24,
//                         fontWeight: FontWeight.w400,
//                         color: Color.fromRGBO(255, 119, 168, 1),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.0),
//
//             // Stack with total price and total items
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   width: 246.0,
//                   height: 54.0,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/total_price_cart.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Rs. ${totalPrice.toStringAsFixed(2)}', // Display total price
//                       style: TextStyle(
//                         fontFamily: 'Game_Tape',
//                         color: Colors.white,
//                         fontSize: 32.0,
//                         fontWeight: FontWeight.w400,
//                         height: 0.9,
//                       ),
//                     ),
//                     Text(
//                       'Total: $totalItems items', // Display total items
//                       style: TextStyle(
//                         fontFamily: 'Game_Tape',
//                         color: Colors.white,
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 20.0),
//
//             // Cart Items List
//             Expanded(
//               child: cartProvider.cartItems.isEmpty
//                   ? Center(
//                       child: Text(
//                         "Your cart is empty!",
//                         style: TextStyle(
//                           fontFamily: 'AlcherPixel',
//                           fontSize: 24,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: cartProvider.cartItems.length,
//                       itemBuilder: (context, index) {
//                         final item = cartProvider.cartItems[index];
//                         return CartCard(
//                           title: item.name,
//                           subtitle: item.type,
//                           price: double.parse(item.price),
//                           size: item.size,
//                           imageUrl: item.imageUrl,
//                           quantity: int.parse(item.count),
//                           onIncrease: () {
//                             cartProvider.updateItemCount(item.name, item.size,
//                                 int.parse(item.count) + 1);
//                           },
//                           onDecrease: () {
//                             cartProvider.updateItemCount(item.name, item.size,
//                                 int.parse(item.count) - 1);
//                           },
//                         );
//                       },
//                     ),
//             ),
//
//             // "Buy" button at the bottom
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CheckoutPage()),
//                 );
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 190.0,
//                     height: 50.47,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/sign_in.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Purchase',
//                     style: TextStyle(
//                       fontFamily: 'Brick_Pixel',
//                       color: Colors.white,
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
