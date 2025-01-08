import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'cart_screen.dart';
import 'eventsearch/searchscreen.dart';
import 'notification/notification_screen.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar({super.key, required this.scaffoldState});

  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  State<TopAppBar> createState() => _TopAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 29, 43, 83),
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CartScreen()));
                },
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
                badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NotificationScreen()));
                  },
                  icon:
                      Image.asset('assets/images/appbar_notification_icon.png'),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Searchscreen()));
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
            widget.scaffoldState.currentState!.openEndDrawer();
          },
          icon: Image.asset(
            'assets/images/appbar_menu_icon.png',
          ),
        ),
      ],
    );
  }
}
