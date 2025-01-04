import 'package:flutter/material.dart';

import '../../widgets/cart_card.dart';

Widget buildReviewTab({
  required String name,
  required String phone,
  required String addressLine1,
  required String addressLine2,
  required String city,
  required String state,
  required String pincode,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 45),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
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
                  padding: EdgeInsets.symmetric(horizontal: 44),
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
            )),
        SizedBox(height: 46),
        Text(
          'Your Orders:',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'Game_Tape',
            fontSize: 16,
            color: Color.fromRGBO(255, 119, 168, 1),
          ),
        ),
        SizedBox(height: 10.0),
        Center(
          // Wrap the CartCard with Center
          child: CartCard(
              title: 'Sweatshirt',
              subtitle: 'crazy eyes',
              price: 78.00,
              size: 'L',
              imageUrl: 'https://picsum.photos/seed/picsum/200/300',
              quantity: 5),
        ),
        SizedBox(
          height: 30,
        ),
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
                        '69',
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
                        '420',
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
                        'Total: 5 items',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 24,
                            color: Color.fromRGBO(131, 118, 156, 1)),
                      ),
                      Text(
                        'Rs. 489',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Game_Tape',
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    ),
  );
}
