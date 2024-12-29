import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/screens/home_screen.dart';
import 'package:alcheringa/screens/map_page.dart';
import 'package:alcheringa/screens/merch_screen.dart';
import 'package:alcheringa/screens/schedule_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  late PageController _pageController = PageController();
  final List<Widget> _pages = [
    const MapPage(),
    const SchedulePage(),
    const HomeScreen(),
    const MerchScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/side_bar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/side_bar_profile_bg.png',
                        width: 80.0,
                        height: 100.0,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: _selectedIndex == 0 ? 0 : 20),
                child: Image.asset(
                  _selectedIndex == 0 ? 'assets/images/map_selected.png' : 'assets/images/map_unselected.png',
                  height: _selectedIndex == 0 ? 90.0 : 70.0,
                ),
              ),
              label: '',
              // backgroundColor: Colors.transparent
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: _selectedIndex == 1 ? 0 : 20),
                child: Image.asset(
                  _selectedIndex == 1 ? 'assets/images/schedule_selected.png' : 'assets/images/schedule_unselected.png',
                  height: _selectedIndex == 1 ? 90.0 : 70.0,
                ),
              ),
              label: '',
              // backgroundColor: Colors.transparent
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: _selectedIndex == 2 ? 0 : 20),
                child: Image.asset(
                  _selectedIndex == 2 ? 'assets/images/home_selected.png' : 'assets/images/home_unselected.png',
                  height: _selectedIndex == 2 ? 90.0 : 70.0,
                ),
              ),
              label: '',
              // backgroundColor: Colors.transparent
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: _selectedIndex == 3 ? 0 : 20),
                child: Image.asset(
                  _selectedIndex == 3 ? 'assets/images/activity_selected.png' : 'assets/images/activity_unselected.png',
                  height: _selectedIndex == 3 ? 90.0 : 70.0,
                ),
              ),
              label: '',
              // backgroundColor: Colors.transparent
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: _selectedIndex == 4 ? 0 : 20),
                child: Image.asset(
                  _selectedIndex == 4 ? 'assets/images/utility_selected.png' : 'assets/images/utility_unselected.png',
                  height: _selectedIndex == 4 ? 90.0 : 70.0,
                ),
              ),
              label: '',
              // backgroundColor: Colors.transparent
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          currentIndex: _selectedIndex,
          onTap: _onTapped,
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}
