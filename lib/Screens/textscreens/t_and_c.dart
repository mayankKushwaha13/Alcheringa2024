import 'package:flutter/material.dart';

import '../../utils/styles/colors.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black.withOpacity(0.5),
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/back_button.png',
                width: 54.0,
                height: 54.0,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5, right: 20),
              child: Text(
                "T&C",
                style: TextStyle(
                  color: AppColors.Pink,
                  fontFamily: "Game_Tape",
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome To Alcheringa!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\nThese terms and conditions outline the rules and regulations for the use of Alcheringa\'s Website, located at Alcheringa  By accessing this website we assume you accept these terms and conditions. Do not continue to use Alcheringa if you do not agree to take all of the terms and conditions stated on this page.\n\n The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company\'s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client\'s needs in respect of provision of the Company\'s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/ or he/she or they, are taken as interchangeable and therefore as referring to same \n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Cookies\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'We employ the use of cookies. By accessing Alcheringa, you agreed to use cookles in agreement with the Alcheringa\'s Privacy Policy. Most interactive websites use cookies to let us retrieve the user\'s details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/ advertising partners may also use cookies.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Licence\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Unless otherwise stated, Alcheringa and/or its licensors own the intellectual property rights for all material on Alcheringa. All intellectual property rights are reserved. You may access this from Alcheringa for your own personal use subjected to restrictions set in these terms and conditions\n You must not: Republish material from Alcheringa Sell, rent or sub-license material from Alcheringa Reproduce, duplicate or copy material from Alcheringa Redistribute content from Alcheringa This Agreement shall begin on the date hereof. Our Terms and Conditions were created with the help of the Terms And Conditions Template. Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Alcheringa does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect theviews and opinions of Alcheringa, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Alcheringa shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website. Alcheringareserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions. You warrant and represent that: You are entitled to post the Comments on our website and haveall necessary licenses and consents to do so The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party: The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy The Comments will not be used to solicit or promote business or custom or presentcommercial activities or unlawful activity. You hereby grant Alcheringa a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Hyperlinking to our Content\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'The following organizations may link to our Website without prior written approval: Government agencies: Search engines: News organizations Online directory distributors may link to our Website in the same manner as they hyperlink to the Websites of other listed businesses, and System wide Accredited Businesses except solliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site. These organizations may link to our home page, to publications or to other Website information so long as the link: a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services and ici fits within the context of the linking party\'s site. We may consider and approve other link requests from the following types of organizations: commonly known consumer and/or business information sources; dot.com.community sites; associations or other groups representing charities; online directory distributors internet portals, accounting, law and consulting firms and educational Institutions and trade associations. We will approve link requests from these organizations If we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses (b) the organization does not have any negative records with us; c) the benefit to us from the visibility of the hyperlink compensates the absence of Alcheringa and (d) the link is in the context of general resource information. These organizations may link to our home page so long as the linic (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services and (c) fits within the context of the linking party\'s site. If you are one of the organizations listed in paragraph 2 above and are interested in linking to our website, you must inform us by sending an e-mail to Alcheringa. Please include your name, your organization name, contact Information as well as the URL of your site, a list of any URLs from which you intend to link to our Website, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response. Approved organizations may hyperlink to our Website as follows: By use of our corporate name or By use of the uniform resource locator being linked to; or By use of any other description of our Website being linked to that makes sense within the context and format of content on the linking party\'s site. No use of Alcheringa\'s logo or other artwork will be allowed for linking absent a trademark license agreement     \n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'iFrames\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our Website.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Content Liability\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'We shall not be hold responsible for any content that appears on your Website. You agree to protect and defend us against all claims that is rising on your Website. No linkis) should appear on any Website that may be interpreted as libelous, obscene or criminal or which infringes, otherwise violates, or advocates the infringement or other violation of any third party rights.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Your Privacy\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Please read Privacy Policy.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Reservation of Rights\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'We reserve the right to request that you remove all links or any particular link to our Website. You approve to immediately remove all links to our Website upon request. We also reserve the right to amen these terms and conditions and It\'s linking policy at any time. By continuously linking to our Website, you agree to be bound to and follow these linking terms and conditions.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Removal of links from our app\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'If you find any link on our Website that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are. not obligated to or so or to respond to you directly. We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy, nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Disclaimer\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our website and the use of this website. Nothing in this disclaimer will: limit or exclude our or your liability for death or personal injury, limit or exclude our or your llability for fraud or fraudulent misrepresentation: limit any of our or your liabilities in any way that is not permitted under applicable law, or exclude any of our or your liabilities that may not be excluded under applicable law. The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: lal are subject to the preceding paragraph; and (bi govern all liabilities arising under the disclaimer, including labilities arising in contract, in tort and for breach of statutory duty. As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                    ],
                  ),
                ),
              ))
            ])),
      ),
    );
  }
}
