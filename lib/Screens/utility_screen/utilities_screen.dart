import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Screens/utility_screen/contact_section.dart';
import 'package:alcheringa/Screens/utility_screen/faq_section.dart';
import 'package:alcheringa/Screens/utility_screen/team_section.dart';
import 'package:flutter/material.dart';

class UtilitiesPage extends StatefulWidget {
  const UtilitiesPage({super.key});

  @override
  State<UtilitiesPage> createState() => _UtilitiesPage();
}

class _UtilitiesPage extends State<UtilitiesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
