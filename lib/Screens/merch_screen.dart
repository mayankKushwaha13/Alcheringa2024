import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/merch_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/merchModel.dart';

class MerchScreen extends StatefulWidget {
  const MerchScreen({super.key});

  @override
  State<MerchScreen> createState() => _MerchScreenState();
}

class _MerchScreenState extends State<MerchScreen> {
  List<MerchModel> merchMerch = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getMerchData();
  }

  Future<void> getMerchData() async {
    try {
      merchMerch = viewModelMain.merchMerch;
    } catch (e) {
      print("Error fetching merchandise: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D2B53),
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
                      'Merchandize',
                      style: TextStyle(
                        fontFamily: 'Game_Tape',
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 119, 168, 1),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Stack(
                children: [
                  ClipRRect(
                    child: Image.asset(
                      "assets/images/1.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Merchandize",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFF1E8),
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.15,
                          ),
                        ),
                      )),
                ],
              ),

              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : merchMerch.isEmpty
                        ? const Center(
                            child: Text(
                              'No Merchandise Available',
                              style: TextStyle(
                                fontFamily: 'Game_Tape',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: merchMerch.map((merch) {
                                return MerchandiseItem(
                                  merch: merch,
                                );
                              }).toList(),
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

class MerchandiseItem extends StatelessWidget {
  final MerchModel merch;

  const MerchandiseItem({
    super.key,
    required this.merch
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MerchDetailScreen(
                merch: merch,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  alignment: Alignment.topCenter,
                  "assets/images/product_details.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CachedNetworkImage(
                      imageUrl: merch.image!,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        merch.type!,
                        style: const TextStyle(
                          fontFamily: 'Game_Tape',
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 241, 232, 1),
                        ),
                      ),
                      Text(
                        merch.name!,
                        style: const TextStyle(
                          fontFamily: 'Game_Tape',
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 119, 168, 1),
                        ),
                      ),
                      Text(
                        'Rs ${merch.price}.00/-',
                        style: const TextStyle(
                          fontFamily: 'Game_Tape',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 241, 232, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /* Padding(
              padding: const EdgeInsets.only(top: 145, left: 3),
              child: Stack(
                children: [
                  Image.asset(
                    color: Colors.black,
                    alignment: Alignment.center,
                    'assets/images/lightpinkbar.png',
                    width: 800,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'DONT MISS OUT - ',
                        style: TextStyle(
                          fontFamily: 'Game_Tape',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 241, 232, 1),
                        ),
                      ),
                      Text(
                        limitedStockMessage,
                        style: const TextStyle(
                          fontFamily: 'Game_Tape',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 119, 168, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ) */
            // Positioned(
            //   right: 0,
            //   left: 0,
            //   bottom: 0,
            //   child: Stack(
            //     children: [
            //       Image.asset(
            //         alignment: Alignment.topCenter,
            //         'assets/images/continue_shopping.png',
            //         width: 180,
            //         fit: BoxFit.cover,
            //       ),
            //       Container(
            //         color: Colors.blue,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 20, right: 20),
            //
            //         child: Text(
            //           "Add to cart",
            //           style: const TextStyle(
            //             fontFamily: 'AlcherPixel',
            //             fontSize: 35,
            //             fontWeight: FontWeight.w400,
            //             color: Color.fromRGBO(255, 241, 232, 1),
            //           ),
            //         ),
            //       ),
            //
            //     ],
            //   ),
            // ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/continue_shopping.png',
                  ),
                  fit: BoxFit.contain,
                )),
                child: Center(
                  child: Text(
                    "Add to cart",
                    style: const TextStyle(
                      fontFamily: 'Brick_Pixel',
                      fontSize: 20,
                      color: Color.fromRGBO(255, 241, 232, 1),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
