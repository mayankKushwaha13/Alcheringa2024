import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Screens/end_drawer.dart';
import 'package:alcheringa/Screens/utility_screen/contact_section.dart';
import 'package:alcheringa/Screens/utility_screen/faq_section.dart';
import 'package:alcheringa/Screens/utility_screen/team_section.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class UtilitiesPage extends StatefulWidget {
  const UtilitiesPage({super.key});

  @override
  State<UtilitiesPage> createState() => _UtilitiesPage();
}

class _UtilitiesPage extends State<UtilitiesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 43, 83),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/appbar_cart_icon.png'),
                ),
                badges.Badge(
                  badgeContent: Text(
                    '2',
                    style: TextStyle(
                      color: Color(0xFFCA3562),
                      fontFamily: 'Alcherpixel',
                    ),
                  ),
                  position: badges.BadgePosition.bottomEnd(bottom: 0, end: 10),
                  badgeStyle:
                  badges.BadgeStyle(badgeColor: Colors.transparent, borderRadius: BorderRadius.circular(5)),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/appbar_notification_icon.png'),
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/appbar_alcheringa.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // Action for first trailing icon
                  },
                  icon: Image.asset('assets/images/appbar_search_icon.png'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Image.asset(
              'assets/images/appbar_menu_icon.png',
            ),
          ),
        ],
      ),
      endDrawer: EndDrawer(scaffoldState: _scaffoldKey),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UtilitiesHeader(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ContactSection(),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FaqSection(),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TeamSection(),
                ),
                SizedBox(height: bottomNavBarHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UtilitiesHeader extends StatelessWidget {
  const UtilitiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/utility_main.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
