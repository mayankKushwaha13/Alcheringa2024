import 'package:flutter/material.dart';
import 'package:alcheringa/widgets/team_member_card.dart';

class TeamSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/the_team.png',
              width: 170,
              height: 52,
            ),
          ),
          Transform.translate(
            offset: Offset(15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Developer ◝ ( ᵔ ᗜᵔ ) ◜',
                  style: TextStyle(
                    fontFamily: 'AlcherPixel',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(255, 163, 0, 1),
                  ),
                ),
                TeamMemberCard(
                  name: 'Doremon',
                  role: 'Head',
                  imagePath: 'assets/images/google.png',
                  onInstagramTap: () {
                    print('Instagram tapped!');
                  },
                  onLinkedInTap: () {
                    print('LinkedIn tapped!');
                  },
                  onMailTap: () {
                    print('Mail tapped!');
                  },
                ),
                TeamMemberCard(
                  name: 'sinchan',
                  role: 'Developer',
                  imagePath: 'assets/images/google.png',
                  onInstagramTap: () {
                    print('Instagram tapped!');
                  },
                  onLinkedInTap: () {
                    print('LinkedIn tapped!');
                  },
                  onMailTap: () {
                    print('Mail tapped!');
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Designers   (｡́•︿•̀｡)',
                  style: TextStyle(
                    fontFamily: 'AlcherPixel',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(255, 163, 0, 1),
                  ),
                ),
                TeamMemberCard(
                  name: 'jerry',
                  role: 'Designer',
                  imagePath: 'assets/images/google.png',
                  onInstagramTap: () {
                    print('Instagram tapped!');
                  },
                  onLinkedInTap: () {
                    print('LinkedIn tapped!');
                  },
                  onMailTap: () {
                    print('Mail tapped!');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
