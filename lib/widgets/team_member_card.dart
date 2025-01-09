import 'package:flutter/material.dart';

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String imagePath;
  final VoidCallback onInstagramTap;
  final VoidCallback onLinkedInTap;
  final VoidCallback onMailTap;

  TeamMemberCard({
    required this.name,
    required this.role,
    required this.imagePath,
    required this.onInstagramTap,
    required this.onLinkedInTap,
    required this.onMailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, // Adjusted height for better spacing
      width: 350, // Adjusted width for better layout
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/team_member_card.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          // Profile Picture Container
          Container(
            margin: const EdgeInsets.all(16),
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Game_Tape',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(126, 37, 83, 1),
                  ),
                ),
                SizedBox(height: 5),
                // Role
                Text(
                  role,
                  style: TextStyle(
                    fontFamily: 'Game_Tape',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(41, 173, 255, 1),
                  ),
                ),
                SizedBox(height: 15),
                // Social Media Icons
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/instagram_icon.png'),
                      iconSize: 24,
                      onPressed: onInstagramTap,
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/linkedin_icon.png'),
                      iconSize: 24,
                      onPressed: onLinkedInTap,
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/mail_icon.png'),
                      iconSize: 24,
                      onPressed: onMailTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
