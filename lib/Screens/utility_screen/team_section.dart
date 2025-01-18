import 'package:flutter/material.dart';
import 'package:alcheringa/widgets/team_member_card.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamSection extends StatelessWidget {
  final List<TeamMember> developerteamMembers = [
    TeamMember(
      name: 'Jivesh Firke',
      role: 'Head',
      imagePath: 'assets/images/jivesh.png',
      onPhoneTap: () => launchUrl(Uri.parse('tel://8308077000')),
      onLinkedInTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/jiveshfirke')),
      onMailTap: () => launchUrl(Uri.parse('mailto:jiveshfirke4749gmail.com')),
    ),
    TeamMember(
      name: 'Akshay Kumar',
      role: 'Developer',
      imagePath: 'assets/images/akshay.jpg',
      onPhoneTap: () =>
          launchUrl(Uri.parse('tel://9133116018')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/akshay-kumar-palakurthy-a66baa281?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () =>
          launchUrl(Uri.parse('mailto:akshaykumarpalakurthy@gmail.com')),
    ),
    TeamMember(
      name: 'Aman',
      role: 'Developer',
      imagePath: 'assets/images/aman.jpg',
      onPhoneTap: () =>
          launchUrl(Uri.parse('tel://9205327169')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/aman-kumar-15a0bb286?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () => launchUrl(Uri.parse('mailto:amankumarajad0@gmail.com')),
    ),
    TeamMember(
      name: 'Arpit Malik',
      role: 'Developer',
      imagePath: 'assets/images/arpit.jpg',
      onPhoneTap: () => launchUrl(Uri.parse(
          'tel://7404992361')),
      onLinkedInTap: () => launchUrl(Uri.parse('')),
      onMailTap: () => launchUrl(Uri.parse('mailto:arpitvenu2004@gmail.com')),
    ),
    TeamMember(
      name: 'Ashish Rana',
      role: 'Developer',
      imagePath: 'assets/images/ashish1.jpg',
      onPhoneTap: () =>
          launchUrl(Uri.parse('tel://9121521199')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/ashish-rana-usilla-a06a99346/')),
      onMailTap: () => launchUrl(Uri.parse('mailto:ashishranau@gmail.com')),
    ),
    TeamMember(
      name: 'Ayan',
      role: 'Developer',
      imagePath: 'assets/images/ayan.jpg',
      onPhoneTap: () =>
          launchUrl(Uri.parse('tel://+917004850831')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/md-ayan-hassan-44a8371a9?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () => launchUrl(Uri.parse('mailto:mdayanhassan718@gmail.com')),
    ),
    TeamMember(
      name: 'Ganesh',
      role: 'Developer',
      imagePath: 'assets/images/ganesh.jpg',
      onPhoneTap: () =>
          launchUrl(Uri.parse('tel://9535160707')),
      onLinkedInTap: () =>
          launchUrl(Uri.parse('https://in.linkedin.com/in/ganesh-sinnur')),
      onMailTap: () => launchUrl(Uri.parse('mailto:ganeshsinnur07@gmail.com')),
    ),
    TeamMember(
      name: 'Gaurav Anand',
      role: 'Developer',
      imagePath: 'assets/images/gaurav.jpg',
      onPhoneTap: () => launchUrl(Uri.parse(
          'tel://8865011121')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/gaurav-anand-26b380296?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () => launchUrl(Uri.parse('mailto:g.anand@iitg.ac.in')),
    ),
    TeamMember(
      name: 'Mayank',
      role: 'Developer',
      imagePath: 'assets/images/mayank.jpg',
      onPhoneTap: () => launchUrl(Uri.parse('tel://7380534884')),
      onLinkedInTap: () => launchUrl(
          Uri.parse('https://www.linkedin.com/in/mayank-kushwaha-768315280')),
      onMailTap: () => launchUrl(Uri.parse('mailto:m.kushwaha@iitg.ac.in')),
    ),
    TeamMember(
      name: 'Shubham',
      role: 'Developer',
      imagePath: 'assets/images/shubham.jpg',
      onPhoneTap: () =>
          launchUrl(Uri.parse('tel://6352301450')),
      onLinkedInTap: () => launchUrl(
          Uri.parse('https://www.linkedin.com/in/shubham-neema-301755280')),
      onMailTap: () => launchUrl(Uri.parse('mailto:shubham.neema@iitg.ac.in')),
    ),
    TeamMember(
      name: 'Sparsh Pawar',
      role: 'Developer',
      imagePath: 'assets/images/sparsh.jpg',
      onPhoneTap: () => launchUrl(Uri.parse(
          'tel://7000454843')),
      onLinkedInTap: () => launchUrl(Uri.parse(
          'https://www.linkedin.com/in/sparsh-pawar-332aa828a?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app')),
      onMailTap: () => launchUrl(Uri.parse('mailto:sparshpawar2209@gmail.com')),
    ),
    TeamMember(
      name: 'Yatika',
      role: 'Developer',
      imagePath: 'assets/images/yatika.jpg',
      onPhoneTap: () =>
          launchUrl(Uri.parse('tel://9337854044')),
      onLinkedInTap: () => launchUrl(
          Uri.parse('https://www.linkedin.com/in/yatika-jena-166122282/')),
      onMailTap: () => launchUrl(Uri.parse('mailto:jenayatika@gmail.com')),
    ),
  ];
  final List<TeamMember> designTeamMembers = [
    TeamMember(
      name: 'Sankeerth',
      role: 'Head',
      imagePath: 'assets/images/sankeerth.png',
      onPhoneTap: () => launchUrl(Uri.parse('tel://8885059696')),
      onLinkedInTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/sai-sankeerth-veggalam')),
      onMailTap: () => launchUrl(Uri.parse('mailto:s.veggalam@iitg.ac.in')),
    ),
    TeamMember(
      name: 'Arin',
      role: 'Designer',
      imagePath: 'assets/images/arin.jpeg',
      onPhoneTap: () => launchUrl(Uri.parse('tel://7003662536')),
      onLinkedInTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/arin-bandyopadhyay-9b99b22b0/')),
      onMailTap: () => launchUrl(Uri.parse('mailto:b.arin@iitg.ac.in')),
    ),
    TeamMember(
      name: 'Shivam',
      role: 'Designer',
      imagePath: 'assets/images/shivam.jpeg',
      onPhoneTap: () => launchUrl(Uri.parse('tel://9279439406')),
      onLinkedInTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/shivam-umaru')),
      onMailTap: () => launchUrl(Uri.parse('maito:shivam.bdes@iitg.ac.in')),
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
