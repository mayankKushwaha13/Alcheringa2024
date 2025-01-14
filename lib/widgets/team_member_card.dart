import 'package:flutter/material.dart';

class TeamMember {
  final String name;
  final String role;
  final String imagePath;
  final VoidCallback onInstagramTap;
  final VoidCallback onLinkedInTap;
  final VoidCallback onMailTap;

  TeamMember({
    required this.name,
    required this.role,
    required this.imagePath,
    required this.onInstagramTap,
    required this.onLinkedInTap,
    required this.onMailTap,
  });
}

class TeamMemberCard extends StatelessWidget {
  final TeamMember teamMember;

  const TeamMemberCard({Key? key, required this.teamMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 350,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/the_team_box.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Blue border PNG
                Image.asset(
                  'assets/images/blue_border.png', // Replace with your blue border PNG
                  fit: BoxFit.cover,
                  width: 110, // Slightly larger than the image
                  height: 110,
                ),
                // Actual profile picture
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    teamMember.imagePath,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teamMember.name,
                  style: TextStyle(
                    fontFamily: 'Game_Tape',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(126, 37, 83, 1),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  teamMember.role,
                  style: TextStyle(
                    fontFamily: 'Game_Tape',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(41, 173, 255, 1),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/instagram_icon.png'),
                      iconSize: 24,
                      onPressed: teamMember.onInstagramTap,
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/linkedin_icon.png'),
                      iconSize: 24,
                      onPressed: teamMember.onLinkedInTap,
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/mail_icon.png'),
                      iconSize: 24,
                      onPressed: teamMember.onMailTap,
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
