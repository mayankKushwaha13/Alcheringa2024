import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Screens/activity_pages/activity_page.dart';
import 'package:alcheringa/Screens/end_drawer.dart';
import 'package:alcheringa/Screens/top_app_bar.dart';
import 'package:alcheringa/Screens/utility_screen/utilities_screen.dart';
import 'package:alcheringa/screens/home_screen.dart';
import 'package:alcheringa/screens/map_page.dart';
import 'package:alcheringa/screens/schedule_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey _bottomNavBarKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int _selectedIndex = 2;
  late PageController _pageController = PageController();
  final List<Widget> _pages = [
    const MapPage(),
    const SchedulePage(),
    const HomeScreen(),
    const ActivityPage(),
    const UtilitiesPage()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateBottomNavBarHeight();
    });
  }

  void _calculateBottomNavBarHeight() {
    final RenderBox? renderBox =
        _bottomNavBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        bottomNavBarHeight = renderBox.size.height;
      });
      print("BottomNavigationBar height: $bottomNavBarHeight");
    }
  }

  void _onTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawer: EndDrawer(
        scaffoldState: _scaffoldKey,
        onTapped: _onTapped,
      ),
      appBar: TopAppBar(scaffoldState: _scaffoldKey),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _pages[_selectedIndex],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(10), // Semi-transparent white
              ),
              child: BottomNavigationBar(
                key: _bottomNavBarKey,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          EdgeInsets.only(top: _selectedIndex == 0 ? 0 : 20),
                      child: Image.asset(
                        _selectedIndex == 0
                            ? 'assets/images/map_selected.png'
                            : 'assets/images/map_unselected.png',
                        height: _selectedIndex == 0 ? 110.0 : 90.0,
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          EdgeInsets.only(top: _selectedIndex == 1 ? 0 : 20),
                      child: Image.asset(
                        _selectedIndex == 1
                            ? 'assets/images/schedule_selected.png'
                            : 'assets/images/schedule_unselected.png',
                        height: _selectedIndex == 1 ? 110.0 : 90.0,
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          EdgeInsets.only(top: _selectedIndex == 2 ? 0 : 20),
                      child: Image.asset(
                        _selectedIndex == 2
                            ? 'assets/images/home_selected.png'
                            : 'assets/images/home_unselected.png',
                        height: _selectedIndex == 2 ? 110.0 : 90.0,
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          EdgeInsets.only(top: _selectedIndex == 3 ? 0 : 20),
                      child: Image.asset(
                        _selectedIndex == 3
                            ? 'assets/images/activity_selected.png'
                            : 'assets/images/activity_unselected.png',
                        height: _selectedIndex == 3 ? 110.0 : 90.0,
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          EdgeInsets.only(top: _selectedIndex == 4 ? 0 : 20),
                      child: Image.asset(
                        _selectedIndex == 4
                            ? 'assets/images/utility_selected.png'
                            : 'assets/images/utility_unselected.png',
                        height: _selectedIndex == 4 ? 110.0 : 90.0,
                      ),
                    ),
                    label: '',
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                currentIndex: _selectedIndex,
                onTap: _onTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
