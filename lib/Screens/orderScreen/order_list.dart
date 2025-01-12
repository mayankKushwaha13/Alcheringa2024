import 'package:alcheringa/Model/orders.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/utils/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MyOrder>>(
      future: ViewModelMain().getOrderDetails(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(
            'No orders found.',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Game_Tape',
              color: Color(0xFFFFF1E8),
            ),
          ));
        }
        final orders = snapshot.data!;
        return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context,index) {
                  final order = orders[index];
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.Pink
                      )
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.3)
                          ),
                          height: 135,
                          width: 135,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: CachedNetworkImage(imageUrl:order.image),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${order.name}",
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(3.0, 3.0), // Horizontal and vertical offset
                                    blurRadius: 5.0, // Blur effect
                                    color: Colors.black, // Shadow color
                                  ),
                                ],
                                color: AppColors.Palewhite,
                                fontFamily: "Game_Tape",
                                fontSize: 25,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text("Quantity: ${order.count}",
                              style: TextStyle(
                                  color: AppColors.Pink,
                                  fontFamily: "Game_Tape",
                                  fontSize: 20
                              ),
                            ),
                            Row(
                              children: [
                                Text("Size: ",
                                  style: TextStyle(
                                    color: AppColors.Palewhite,
                                    fontFamily: "Game_Tape",
                                    fontSize: 15,
                                  ),
                                ),
                                Text("${order.size}",
                                  style: TextStyle(
                                    color: AppColors.Palewhite,
                                    fontFamily: "Brick_Pixel",
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Text(
                                  "Order Placed",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: AppColors.Palewhite,
                                    fontFamily: "Game_Tape",
                                    fontSize: 20,
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ],

                    ),
                  );
                });
      }
    );

  }
}
