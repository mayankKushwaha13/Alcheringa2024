import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/checkout_pages/checkout_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';




/* Widget buildReviewTab({
  required BuildContext context, // Pass context to access CartProvider
  required String name,
  required String phone,
  required String addressLine1,
  required String addressLine2,
  required String city,
  required String state,
  required String pincode,
}) {
  final cartProvider =
      Provider.of<CartProvider>(context); // Access CartProvider

  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery Information
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns columns at the top
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Deliver to:',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Color.fromRGBO(131, 118, 156, 1),
                        )),
                    SizedBox(height: 1),
                    Text(name,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    SizedBox(height: 22),
                    Text("Recipient's Ph No.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Color.fromRGBO(131, 118, 156, 1),
                        )),
                    SizedBox(height: 1),
                    Text(phone,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address:',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Color.fromRGBO(131, 118, 156, 1),
                          )),
                      SizedBox(height: 1),
                      Text(
                        addressLine1, // Concatenating with a space between lines
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        softWrap: true, // Allows text to wrap to the next line
                        overflow: TextOverflow
                            .ellipsis, // Ensures overflow is handled
                      ),
                      Container(
                        width: 130,
                        child: Text(
                          addressLine2, // Concatenating with a space between lines
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          softWrap:
                              true, // Allows text to wrap to the next line
                          overflow: TextOverflow
                              .ellipsis, // Ensures overflow is handled
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 46),
          // Orders Section
          Text(
            'Your Orders:',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Game_Tape',
              fontSize: 20,
              color: Color.fromRGBO(255, 119, 168, 1),
            ),
          ),
          SizedBox(height: 10.0),

          // Cart Items List
          if (cartProvider.cartItems.isEmpty)
            Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(
                  fontFamily: 'Game_Tape',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true, // Prevent infinite height error
              physics: NeverScrollableScrollPhysics(), // Disable scrolling
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return checkoutcard(
                  title: item.name,
                  subtitle: item.type,
                  price: double.parse(item.price),
                  size: item.size,
                  imageUrl: item.imageUrl,
                  quantity: int.parse(item.count),
                );
              },
            ),
          SizedBox(height: 30),

          // Summary Section
          Container(
            width: 325,
            height: 105,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(131, 118, 156, 1), width: 3)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price:',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Color.fromRGBO(131, 118, 156, 1)),
                      ),
                      Text(
                        'Rs. ${cartProvider.totalPrice.toStringAsFixed(2)}', // Use CartProvider
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Color.fromRGBO(131, 118, 156, 1)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping charges:',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Color.fromRGBO(131, 118, 156, 1)),
                      ),
                      Text(
                        cartProvider.totalPrice.toStringAsFixed(2) != '0.00'
                            ? 'Rs. 420'
                            : '0', // Static for now; update as needed
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Color.fromRGBO(131, 118, 156, 1)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${cartProvider.totalItems} items', // Use CartProvider
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 23,
                            color: Color.fromRGBO(131, 118, 156, 1)),
                      ),
                      Text(
                        'Rs. ${(cartProvider.totalPrice + cartProvider.totalItems != 0 ? 420 : 0).toStringAsFixed(2)}', // Include shipping
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 23,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
} */

class BuildReviewTab extends StatefulWidget {
  final String name;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String pincode;
  const BuildReviewTab({super.key, required this.name, required this.phone, required this.addressLine1, required this.addressLine2, required this.city, required this.state, required this.pincode,});

  @override
  State<BuildReviewTab> createState() => _BuildReviewTabState();
}

class _BuildReviewTabState extends State<BuildReviewTab> {

  int shippingCharges =0;

  @override
  void initState() {
    getDatas();
    super.initState();
  }

  Future<void> getDatas() async {
    shippingCharges = await ViewModelMain().getShippingPrice()??0;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider =
      Provider.of<CartProvider>(context);
    return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery Information
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns columns at the top
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Deliver to:',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Color.fromRGBO(131, 118, 156, 1),
                        )),
                    SizedBox(height: 1),
                    Text(widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    SizedBox(height: 22),
                    Text("Recipient's Ph No.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Color.fromRGBO(131, 118, 156, 1),
                        )),
                    SizedBox(height: 1),
                    Text(widget.phone,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address:',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Color.fromRGBO(131, 118, 156, 1),
                          )),
                      SizedBox(height: 1),
                      Text(
                        widget.addressLine1, // Concatenating with a space between lines
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Game_Tape',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        softWrap: true, // Allows text to wrap to the next line
                        overflow: TextOverflow
                            .ellipsis, // Ensures overflow is handled
                      ),
                      Container(
                        width: 130,
                        child: Text(
                          widget.addressLine2, // Concatenating with a space between lines
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          softWrap:
                              true, // Allows text to wrap to the next line
                          overflow: TextOverflow
                              .ellipsis, // Ensures overflow is handled
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 46),
          // Orders Section
          Text(
            'Your Orders:',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Game_Tape',
              fontSize: 20,
              color: Color.fromRGBO(255, 119, 168, 1),
            ),
          ),
          SizedBox(height: 10.0),

          // Cart Items List
          if (cartProvider.cartItems.isEmpty)
            Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(
                  fontFamily: 'Game_Tape',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true, // Prevent infinite height error
              physics: NeverScrollableScrollPhysics(), // Disable scrolling
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return checkoutcard(
                  title: item.name,
                  subtitle: item.type,
                  price: double.parse(item.price),
                  size: item.size,
                  imageUrl: item.imageUrl,
                  quantity: int.parse(item.count),
                );
              },
            ),
          SizedBox(height: 30),

          // Summary Section
          Center(
            child: Container(
              width: 325,
              height: 105,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(131, 118, 156, 1), width: 3)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price:',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Game_Tape',
                              fontSize: 16,
                              color: Color.fromRGBO(131, 118, 156, 1)),
                        ),
                        Text(
                          'Rs. ${cartProvider.totalPrice.toStringAsFixed(2)}', // Use CartProvider
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Game_Tape',
                              fontSize: 16,
                              color: Color.fromRGBO(131, 118, 156, 1)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping charges:',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Game_Tape',
                              fontSize: 16,
                              color: Color.fromRGBO(131, 118, 156, 1)),
                        ),
                        Text(
                          shippingCharges==0||shippingCharges==null?"--":shippingCharges.toString(),
                          
                          /* 
                          cartProvider.totalPrice.toStringAsFixed(2) != '0.00'
                              ? 'Rs. 420'
                              : '0', */ // Static for now; update as needed
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Game_Tape',
                              fontSize: 16,
                              color: Color.fromRGBO(131, 118, 156, 1)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ${cartProvider.totalItems} items', // Use CartProvider
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Game_Tape',
                              fontSize: 23,
                              color: Color.fromRGBO(131, 118, 156, 1)),
                        ),
                        Text(
                          'Rs. ${(cartProvider.totalPrice+shippingCharges).toStringAsFixed(2)}', // Include shipping
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Game_Tape',
                              fontSize: 23,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
// import '../../widgets/cart_card.dart';
//
// Widget buildReviewTab({
//   required String name,
//   required String phone,
//   required String addressLine1,
//   required String addressLine2,
//   required String city,
//   required String state,
//   required String pincode,
// }) {
//   return Padding(
//     padding: EdgeInsets.only(left: 45),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//             padding: EdgeInsets.only(right: 10),
//             child: Row(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start, // Aligns columns at the top
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Deliver to:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontFamily: 'Game_Tape',
//                           fontSize: 16,
//                           color: Color.fromRGBO(131, 118, 156, 1),
//                         )),
//                     SizedBox(height: 1),
//                     Text(name,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontFamily: 'Game_Tape',
//                           fontSize: 16,
//                           color: Colors.white,
//                         )),
//                     SizedBox(height: 22),
//                     Text("Recipient's Ph No.",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontFamily: 'Game_Tape',
//                           fontSize: 16,
//                           color: Color.fromRGBO(131, 118, 156, 1),
//                         )),
//                     SizedBox(height: 1),
//                     Text(phone,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontFamily: 'Game_Tape',
//                           fontSize: 16,
//                           color: Colors.white,
//                         )),
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 44),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Address:',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Game_Tape',
//                             fontSize: 16,
//                             color: Color.fromRGBO(131, 118, 156, 1),
//                           )),
//                       SizedBox(height: 1),
//                       Text(
//                         addressLine1, // Concatenating with a space between lines
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontFamily: 'Game_Tape',
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                         softWrap: true, // Allows text to wrap to the next line
//                         overflow: TextOverflow
//                             .ellipsis, // Ensures overflow is handled
//                       ),
//                       Container(
//                         width: 130,
//                         child: Text(
//                           addressLine2, // Concatenating with a space between lines
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Game_Tape',
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                           softWrap:
//                               true, // Allows text to wrap to the next line
//                           overflow: TextOverflow
//                               .ellipsis, // Ensures overflow is handled
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )),
//         SizedBox(height: 46),
//         Text(
//           'Your Orders:',
//           style: TextStyle(
//             fontWeight: FontWeight.w400,
//             fontFamily: 'Game_Tape',
//             fontSize: 16,
//             color: Color.fromRGBO(255, 119, 168, 1),
//           ),
//         ),
//         SizedBox(height: 10.0),
//         Center(
//           // Wrap the CartCard with Center
//           child: // Cart Items List
//               Expanded(
//             child: cartItems.isEmpty
//                 ? Center(
//                     child: Text(
//                       "Your cart is empty!",
//                       style: TextStyle(
//                         fontFamily: 'AlcherPixel',
//                         fontSize: 24,
//                         color: Colors.white,
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: cartItems.length,
//                     itemBuilder: (context, index) {
//                       final item = cartItems[index];
//                       return CartCard(
//                         title: item.name,
//                         subtitle: item.type,
//                         price: double.parse(item.price),
//                         size: item.size,
//                         imageUrl: item.imageUrl,
//                         quantity: int.parse(item.count),
//                         onIncrease: () {
//                           int newCount = int.parse(item.count) + 1;
//                           updateItemCount(item.name, item.size, newCount);
//                         },
//                         onDecrease: () {
//                           int newCount = int.parse(item.count) - 1;
//                           if (newCount > 0) {
//                             updateItemCount(item.name, item.size, newCount);
//                           } else {
//                             dbHandler.deleteItem(item.name, item.size);
//                             fetchCartItems();
//                           }
//                         },
//                       );
//                     },
//                   ),
//           ),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         Container(
//             width: 325,
//             height: 105,
//             decoration: BoxDecoration(
//                 border: Border.all(
//                     color: Color.fromRGBO(131, 118, 156, 1), width: 3)),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Price:',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Game_Tape',
//                             fontSize: 16,
//                             color: Color.fromRGBO(131, 118, 156, 1)),
//                       ),
//                       Text(
//                         '69',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Game_Tape',
//                             fontSize: 16,
//                             color: Color.fromRGBO(131, 118, 156, 1)),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Shipping charges:',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Game_Tape',
//                             fontSize: 16,
//                             color: Color.fromRGBO(131, 118, 156, 1)),
//                       ),
//                       Text(
//                         '420',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Game_Tape',
//                             fontSize: 16,
//                             color: Color.fromRGBO(131, 118, 156, 1)),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Total: 5 items',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Game_Tape',
//                             fontSize: 24,
//                             color: Color.fromRGBO(131, 118, 156, 1)),
//                       ),
//                       Text(
//                         'Rs. 489',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'Game_Tape',
//                             fontSize: 24,
//                             color: Colors.white),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )),
//       ],
//     ),
//   );
// }
