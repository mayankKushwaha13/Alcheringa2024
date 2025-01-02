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

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    getMerchData();
  }

  Future<void> getMerchData() async {
    setState(() async {
      merchMerch = await ViewModelMain().getMerchMerch();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sample data for merchandise items
    final List<Map<String, dynamic>> merchItems = [
      {
        'image1': 'assets/images/3.png',
        'image2': 'assets/images/2.png',
        'title': 'SWEATSHIRT',
        'subtitle': 'CRAZY EYES',
        'price': '850.00',
        'limitedStockMessage': 'LIMITED STOCK AVAILABLE'
      },
      {
        'image1': 'assets/images/3.png',
        'image2': 'assets/images/2.png',
        'title': 'T-SHIRT',
        'subtitle': 'CRAZY EYES',
        'price': '500.00',
        'limitedStockMessage': 'LIMITED STOCK AVAILABLE'
      },
      {
        'image1': 'assets/images/3.png',
        'image2': 'assets/images/2.png',
        'title': 'HOODIE',
        'subtitle': 'CRAZY EYES',
        'price': '500.00',
        'limitedStockMessage': 'LIMITED STOCK AVAILABLE'
      },
      {
        'image1': 'assets/images/3.png',
        'image2': 'assets/images/2.png',
        'title': 'SOME CRAZY SHIT',
        'subtitle': 'CRAZY EYES',
        'price': '500.00',
        'limitedStockMessage': 'LIMITED STOCK AVAILABLE'
      },
      {
        'image1': 'assets/images/3.png',
        'image2': 'assets/images/2.png',
        'title': 'JACKET',
        'subtitle': 'CRAZY EYES',
        'price': '500.00',
        'limitedStockMessage': 'LIMITED STOCK AVAILABLE'
      },
      // Add more items here
    ];

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
                    'Merchandise',
                    style: TextStyle(
                      fontFamily: 'AlcherPixel',
                      fontSize: 24,
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
              child: SingleChildScrollView(
                child: Column(
                  children: merchItems.map((item) {
                    return MerchandiseItem(
                      image1: item['image1'],
                      image2: item['image2'],
                      title: item['title'],
                      subtitle: item['subtitle'],
                      price: item['price'],
                      limitedStockMessage: item['limitedStockMessage'],
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MerchandiseItem extends StatelessWidget {
  final String image1;
  final String image2;
  final String title;
  final String subtitle;
  final String price;
  final String limitedStockMessage;

  const MerchandiseItem({
    super.key,
    required this.image1,
    required this.image2,
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
                merchName: title,
                merchDescription: subtitle,
                price: price,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Image.asset(
              alignment: Alignment.topCenter,
              image1,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              alignment: Alignment.topCenter,
              image2,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 40),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'AlcherPixel',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 241, 232, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 72, left: 80),
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'AlcherPixel',
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 241, 232, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Stack(
                children: [
                  Image.asset(
                    color: Colors.black,
                    alignment: Alignment.center,
                    'assets/images/lightpinkbar.png',
                    width: double.infinity,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'DONT MISS OUT - ',
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 241, 232, 1),
                        ),
                      ),
                      Text(
                        limitedStockMessage,
                        style: const TextStyle(
                          fontFamily: 'AlcherPixel',
                          fontSize: 20,
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
              padding: const EdgeInsets.fromLTRB(100, 200, 1, 1),
              child: Stack(
                children: [
                  Image.asset(
                    alignment: Alignment.topCenter,
                    'assets/images/sign_in.png',
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 20),
                    child: Text(
                      price,
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
