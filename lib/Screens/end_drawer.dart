import 'dart:developer';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Screens/orderScreen/order_screen.dart';
import 'package:alcheringa/Screens/profile_setup/profile_page.dart';
import 'package:alcheringa/Screens/sponsersScreen/sponser_screen.dart';
import 'package:alcheringa/Screens/welcome_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Model/view_model_main.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key, required this.scaffoldState, required this.onTapped});

  final GlobalKey<ScaffoldState> scaffoldState;
  final Function onTapped;

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  String? photoURL = '';
  String name = '';

  Future<String?> _loadImage() async {
    photoURL = await ViewModelMain().getValue('PhotoURL');
    try {
      final response = await NetworkImage(photoURL!).resolve(ImageConfiguration());
      if (response == null) {
        throw Exception('Failed to load image');
      }
      return photoURL; // Return the URL if it loads successfully
    } catch (e) {
      return null; // Return null if the URL image fails to load
    }
  }

  Future<String> _getName() async {
    name = await ViewModelMain().getValue('userName');
    return name;
  }

  @override
  Widget build(BuildContext context) {
    //data for side bar population
    final List<Map<String, dynamic>> sideBarItemsList1 = [
      {
        'name': 'PROFILE',
        'iconPath': 'assets/images/sidebar_profile_icon.png',
        'onTap': () {
          widget.scaffoldState.currentState!.closeEndDrawer();
          Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
        },
      },
      {
        'name': 'FAQ',
        'iconPath': 'assets/images/sidebar_faq_icon.png',
        'onTap': () {
          widget.scaffoldState.currentState!.closeEndDrawer();
          widget.onTapped(4);
        },
      },
      {
        'name': 'ORDERS',
        'iconPath': 'assets/images/sidebar_orders_icon.png',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => orderScreen()),
          );
        },
      },
      {
        'name': 'CONTACT US',
        'iconPath': 'assets/images/sidebar_contactus_icon.png',
        'onTap': () {
          widget.scaffoldState.currentState!.closeEndDrawer();
          widget.onTapped(4);
        },
      },
    ];

    final List<Map<String, dynamic>> sideBarItemsList2 = [
      {
        'name': 'TEAMS',
        'iconPath': 'assets/images/sidebar_team_icon.png',
        'onTap': () {
          widget.scaffoldState.currentState!.closeEndDrawer();
          widget.onTapped(4);
        },
      },
      {
        'name': 'SPONSORS',
        'iconPath': 'assets/images/sidebar_sponsors_icon.png',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => sponsorScreen()),
          );
        },
      },
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomNavBarHeight),
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.zero,
                  image: DecorationImage(
                    image: AssetImage('assets/images/sidebar_bg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListView(
                padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 39.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/sidebar_profile_bg.png',
                        ),
                        Column(
                          children: [
                            FutureBuilder(
                              future: _loadImage(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                  return CachedNetworkImage(
                                    imageUrl:snapshot.data!,
                                    width: 120.0, // Adjust size
                                    height: 120.0,
                                    fit: BoxFit.cover
                                  );
                                }
                                // log("HERE");
                                return Image.asset(
                                  'assets/images/cat.jpg',
                                  width: 120.0, // Adjust size
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/images/sidebar_profile_name_bg.png'),
                                FutureBuilder(
                                  future: _getName(),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data ?? "Unknown",
                                      style: TextStyle(fontSize: 16.0, fontFamily: 'Game_Tape', color: Colors.white),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ...sideBarItemsList1.map(
                    (item) => SideBarItems(
                      name: item['name'],
                      iconPath: item['iconPath'],
                      onTap: item['onTap'],
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  ...sideBarItemsList2.map(
                    (item) => SideBarItems(
                      name: item['name'],
                      iconPath: item['iconPath'],
                      onTap: item['onTap'],
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SideBarItems(
                    name: 'SIGN OUT',
                    iconPath: 'assets/images/sidebar_signout_icon.png',
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => welcomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                      auth.signOut();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideBarItems extends StatelessWidget {
  final String name;
  final String iconPath;
  final VoidCallback onTap;

  const SideBarItems({super.key, required this.name, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            height: 20.0,
            width: 20.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Image.asset(
                  'assets/images/sidebar_item_bg.png',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 18.0, fontFamily: 'Game_Tape', color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
