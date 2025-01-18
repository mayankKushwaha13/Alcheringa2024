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
            margin: const EdgeInsets.fromLTRB(2, 2, 2, 8),
            width: 145,
            height: 145,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Blue border PNG
                Image.asset(
                  'assets/images/blue_border.png', // Replace with your blue border PNG
                  fit: BoxFit.cover,
                  width: 130, // Slightly larger than the image
                  height: 130,
                ),
                // Actual profile picture
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    teamMember.imagePath,
                    fit: BoxFit.cover,
                    width: 115,
                    height: 115,
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
                SizedBox(
                  height: 25,
                ),
                Text(
                  teamMember.name,
                  style: TextStyle(
                    fontFamily: 'Game_Tape',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(126, 37, 83, 1),
                  ),
                ),
                // SizedBox(height: 5),
                Text(
                  teamMember.role,
                  style: TextStyle(
                    fontFamily: 'Game_Tape',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(41, 173, 255, 1),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
