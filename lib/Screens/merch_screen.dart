import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/merch_detail_screen.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    getMerchData();
  }

  Future<void> getMerchData() async {
    try {
      merchMerch = await ViewModelMain().getMerchMerch();
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
            // Header Section
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                    'MERCHANDIZE',
                    style: TextStyle(
                      fontFamily: 'AlcherPixel',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(255, 119, 168, 1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Stack(children: [
              Image.asset(
                alignment: Alignment.topCenter,
                'assets/images/1.png', // Replace with your image path
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'Merchandise',
                    style: TextStyle(
                      fontFamily: 'AlcherPixel',
                      fontSize: 27,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(255, 241, 232, 1),
                    ),
                  ),
                ],
              ))
            ]),

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
                              fontFamily: 'AlcherPixel',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: merchMerch.map((merch) {
                              return MerchandiseItem(
                                image: merch.image ?? 'assets/images/default_image.png',
                                title: merch.type ?? 'Unnamed',
                                subtitle: merch.name ?? 'Unnamed',
                                description: merch.description ?? 'No description',
                                price: merch.price ?? '0.00',
                                limitedStockMessage: merch.available == true
                                    ? 'LIMITED STOCK AVAILABLE'
                                    : 'OUT OF STOCK',
                              );
                            }).toList(),
                          ),
                        ),
            ),
          ],
        ),
      ),
      
    );
  }
}

class MerchandiseItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String price;
  final String limitedStockMessage;

  const MerchandiseItem({
    super.key,
    required this.image,
    required this.description,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.limitedStockMessage,
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
                merchTitle: title,
                merchSubtitle: subtitle,
                merchDescription: description,
                price: price,
                image: image,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Image.asset(
              alignment: Alignment.topCenter,
              "assets/images/product_details.png",
              width: 500,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.network(
                image,
                width: 80,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50, left: 180),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'AlcherPixelBold',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 241, 232, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 72, left: 180),
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'AlcherPixel',
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 119, 168, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 180),
              child: Text(
                'Rs $price.00/-',
                style: const TextStyle(
                  fontFamily: 'AlcherPixel',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 241, 232, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160, left: 5),
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
                          fontFamily: 'AlcherPixel',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 241, 232, 1),
                        ),
                      ),
                      Text(
                        limitedStockMessage,
                        style: const TextStyle(
                          fontFamily: 'AlcherPixel',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 119, 168, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 180, 1, 1),
              child: Stack(
                children: [
                  Image.asset(
                    alignment: Alignment.topCenter,
                    'assets/images/continue_shopping.png',
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Add to cart",
                      style: const TextStyle(
                        fontFamily: 'AlcherPixel',
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 241, 232, 1),
                      ),
                    ),
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


