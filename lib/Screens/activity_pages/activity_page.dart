import 'package:alcheringa/Screens/activity_pages/competitionpage.dart';
import 'package:alcheringa/Screens/activity_pages/stalls_page.dart';
import 'package:flutter/material.dart';

import 'activity_events_screen.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final PageController _pageController = PageController();
  int _selectedTab = 0;

  final List<Widget> _allTabs = [ActivityEventsScreen(), CompetitionsWidget(), StallsPage(),];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changeTab(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
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
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1A237E),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_alcher_app_25.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main Content
          Column(
            children: [
              // Tabs
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70,
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _changeTab(0);
                            setState(() {
                              _selectedTab = 0;
                            });
                          },
                          child: Image.asset(
                            _selectedTab == 0
                                ? 'assets/images/events_icon_selected.png'
                                : 'assets/images/events_icon_unselected.png',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _changeTab(1);
                            setState(() {
                              _selectedTab = 1;
                            });
                          },
                          child: Image.asset(
                            _selectedTab == 1
                                ? 'assets/images/competitions_icon_selected.png'
                                : 'assets/images/competitions_icon_unselected.png',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _changeTab(2);
                            setState(() {
                              _selectedTab = 2;
                            });
                          },
                          child: Image.asset(
                            _selectedTab == 2
                                ? 'assets/images/stalls_icon_selected.png'
                                : 'assets/images/stalls_icon_unselected.png',
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
              // PageView
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                  children: _allTabs,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
