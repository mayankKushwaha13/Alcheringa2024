import 'package:flutter/material.dart';
import 'package:alcheringa/widgets/team_member_card.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamSection extends StatelessWidget {
  final List<TeamMember> developerteamMembers = [
    TeamMember(
      name: 'Jivesh Firke',
      role: 'Head',
      imagePath: 'assets/images/the_team_image.png',
      onInstagramTap: () => print('https://www.instagram.com/jiveshfirke/'),
      onLinkedInTap: () => print('https://www.linkedin.com/in/jiveshfirke'),
      onMailTap: () => print('mailto:jiveshfirke4749gmail.com'),
    ),
    TeamMember(
      name: 'Akshay Kumar',
      role: 'Developer',
      imagePath: 'assets/images/akshay.jpg',
      onInstagramTap: () =>
          launchUrl(Uri.parse('https://www.instagram.com/akshay_kumar104_/#')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/akshay-kumar-palakurthy-a66baa281?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () =>
          launchUrl(Uri.parse('mailto:akshaykumarpalakurthy@gmail.com')),
    ),
    TeamMember(
      name: 'Aman',
      role: 'Developer',
      imagePath: 'assets/images/aman.jpg',
      onInstagramTap: () =>
          launchUrl(Uri.parse('https://www.instagram.com/itz_ak_')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/aman-kumar-15a0bb286?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () => launchUrl(Uri.parse('mailto:amankumarajad0@gmail.com')),
    ),
    TeamMember(
      name: 'Arpit Malik',
      role: 'Developer',
      imagePath: 'assets/images/arpit.jpg',
      onInstagramTap: () => launchUrl(Uri.parse(
          'https://www.instagram.com/_arpit_m_/?igsh=MXdyendxYWdzdHZneA%3D%3D')),
      onLinkedInTap: () => launchUrl(Uri.parse('')),
      onMailTap: () => launchUrl(Uri.parse('mailto:arpitvenu2004@gmail.com')),
    ),
    TeamMember(
      name: 'Ashish Rana',
      role: 'Developer',
      imagePath: 'assets/images/ashish1.jpg',
      onInstagramTap: () =>
          launchUrl(Uri.parse('https://www.instagram.com/ashishranau/')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/ashish-rana-usilla-a06a99346/')),
      onMailTap: () => launchUrl(Uri.parse('mailto:ashishranau@gmail.com')),
    ),
    TeamMember(
      name: 'Ayan',
      role: 'Developer',
      imagePath: 'assets/images/ayan.jpg',
      onInstagramTap: () =>
          launchUrl(Uri.parse('https://www.instagram.com/ayan_/')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/md-ayan-hassan-44a8371a9?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () => launchUrl(Uri.parse('mailto:mdayanhassan718@gmail.com')),
    ),
    TeamMember(
      name: 'Ganesh',
      role: 'Developer',
      imagePath: 'assets/images/ganesh.jpg',
      onInstagramTap: () =>
          launchUrl(Uri.parse('https://www.instagram.com/ganesh_sinnur/')),
      onLinkedInTap: () =>
          launchUrl(Uri.parse('https://in.linkedin.com/in/ganesh-sinnur')),
      onMailTap: () => launchUrl(Uri.parse('mailto:ganeshsinnur07@gmail.com')),
    ),
    TeamMember(
      name: 'Gaurav Anand',
      role: 'Developer',
      imagePath: 'assets/images/gaurav.jpg',
      onInstagramTap: () => launchUrl(Uri.parse(
          'https://www.instagram.com/gaurav_ana.nd?igsh=cmxrb3lleTRyN3Q4')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/gaurav-anand-26b380296?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () => launchUrl(Uri.parse('mailto:g.anand@iitg.ac.in')),
    ),
    TeamMember(
      name: 'Mayank',
      role: 'Developer',
      imagePath: 'assets/images/mayank.jpg',
      onInstagramTap: () => launchUrl(Uri.parse('')),
      onLinkedInTap: () => launchUrl(
          Uri.parse('https://www.linkedin.com/in/mayank-kushwaha-768315280')),
      onMailTap: () => launchUrl(Uri.parse('mailto:m.kushwaha@iitg.ac.in')),
    ),
    TeamMember(
      name: 'Shubham',
      role: 'Developer',
      imagePath: 'assets/images/shubham.jpg',
      onInstagramTap: () =>
          launchUrl(Uri.parse('https://www.instagram.com/shubham._.1105/')),
      onLinkedInTap: () => launchUrl(
          Uri.parse('https://www.linkedin.com/in/shubham-neema-301755280')),
      onMailTap: () => launchUrl(Uri.parse('mailto:shubham.neema@iitg.ac.in')),
    ),
    TeamMember(
      name: 'Sparsh Pawar',
      role: 'Developer',
      imagePath: 'assets/images/sparsh.jpg',
      onInstagramTap: () => launchUrl(Uri.parse(
          'https://www.instagram.com/sparshpawar22?igsh=MXI5cTc0OGNtNjV6eA==')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/sparsh-pawar-332aa828a?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () => launchUrl(Uri.parse('mailto:sparshpawar2209@gmail.com')),
    ),
    TeamMember(
      name: 'Yatika',
      role: 'Developer',
      imagePath: 'assets/images/yatika.jpg',
      onInstagramTap: () =>
          launchUrl(Uri.parse('https://www.instagram.com/yatika_j/')),
      onLinkedInTap: () => launchUrl(
          Uri.parse('https://www.linkedin.com/in/yatika-jena-166122282/')),
      onMailTap: () => launchUrl(Uri.parse('mailto:jenayatika@gmail.com')),
    ),
  ];
  final List<TeamMember> designTeamMembers = [
    TeamMember(
      name: 'Sinchan',
      role: 'Developer',
      imagePath: 'assets/images/the_team_image.png',
      onInstagramTap: () => print('Sinchan Instagram tapped!'),
      onLinkedInTap: () => print('Sinchan LinkedIn tapped!'),
      onMailTap: () => print('Sinchan Mail tapped!'),
    ),
    TeamMember(
      name: 'Sinchan',
      role: 'Developer',
      imagePath: 'assets/images/the_team_image.png',
      onInstagramTap: () => print('Sinchan Instagram tapped!'),
      onLinkedInTap: () => print('Sinchan LinkedIn tapped!'),
      onMailTap: () => print('Sinchan Mail tapped!'),
    ),
    TeamMember(
      name: 'Sinchan',
      role: 'Developer',
      imagePath: 'assets/images/the_team_image.png',
      onInstagramTap: () => print('Sinchan Instagram tapped!'),
      onLinkedInTap: () => print('Sinchan LinkedIn tapped!'),
      onMailTap: () => print('Sinchan Mail tapped!'),
    ),
  ];
  void openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
          ...developerteamMembers
              .map((member) => Center(child: TeamMemberCard(teamMember: member)))
              .toList(),
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
          ...designTeamMembers
              .map((member) => Center(child: TeamMemberCard(teamMember: member)))
              .toList(),
        ],
      ),
    );
  }
}
