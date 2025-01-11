import 'package:flutter/material.dart';
import 'package:alcheringa/widgets/team_member_card.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/the_team.png',
                width: 170,
                height: 52,
              ),
              Text(
                'Developer ◝ ( ᵔ ᗜᵔ ) ◜',
                style: TextStyle(
                  fontFamily: 'Game_Tape',
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 163, 0, 1),
                ),
              ),
              TeamMemberCard(
                name: 'Doremon',
                role: 'Head',
                imagePath: 'assets/images/the_team_image.png',
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
                imagePath: 'assets/images/the_team_image.png',
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
                  fontFamily: 'Game_Tape',
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(255, 163, 0, 1),
                ),
              ),
              TeamMemberCard(
                name: 'jerry',
                role: 'Designer',
                imagePath: 'assets/images/the_team_image.png',
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
        ],
      ),
    );
  }
}
