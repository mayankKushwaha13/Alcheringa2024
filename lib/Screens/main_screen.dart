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
  String? photoURL = '';
  String name = '';
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
        'onTap': () {},
      },
      {
        'name': 'FAQ',
        'iconPath': 'assets/images/sidebar_faq_icon.png',
        'onTap': () {},
      },
      {
        'name': 'ORDERS',
        'iconPath': 'assets/images/sidebar_orders_icon.png',
        'onTap': () {},
      },
      {
        'name': 'CONTACT US',
        'iconPath': 'assets/images/sidebar_contactus_icon.png',
        'onTap': () {},
      },
    ];

    final List<Map<String, dynamic>> sideBarItemsList2 = [
      {
        'name': 'TEAMS',
        'iconPath': 'assets/images/sidebar_team_icon.png',
        'onTap': () {},
      },
      {
        'name': 'SPONSORS',
        'iconPath': 'assets/images/sidebar_sponsors_icon.png',
        'onTap': () {},
      },
    ];

    return Scaffold(
      endDrawer: SafeArea(
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
                                if (snapshot.hasData) {
                                  return Image.network(
                                    snapshot.data!,
                                    width: 120.0, // Adjust size
                                    height: 120.0,
                                  );
                                }
                                return Image.asset(
                                  'assets/images/home_selected.png',
                                  width: 70.0, // Adjust size
                                  height: 70.0,
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
                                      style: TextStyle(fontSize: 16.0, fontFamily: 'Alcherpixel', color: Colors.white),
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

                    },
                  )
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
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Alcherpixel', color: Colors.white),
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
