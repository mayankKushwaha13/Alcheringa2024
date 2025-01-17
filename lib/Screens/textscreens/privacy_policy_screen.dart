import 'package:flutter/material.dart';

import '../../utils/styles/colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
                "PRIVACY POLICY",
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
                        'Alcheringa built the Alcheringa app as a Free app. This service is provided by Alcheringa at no cost and is intended for use as is.\nThis page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.\nIf you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and Improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Alcheringa unless otherwise defined in this Privacy Policy.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Information Collection and Use\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The Information that we request will be retained by us and used as described in this privacy policy.\nThe app does use third-party services that may collect information used to identify you.\nLink to the privacy policy of third-party service providers used by the app: Google Play Services',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Log Data\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol ("IP") address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.\n',
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
                        'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device\'s internal memory. This Service does not use these "cookies" explicitly. However, the app may use third-party code and libraries that use "cookies" to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Service Providers\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'We may employ third-party companies and Individuals due to the following reasons: To facilitate our Service; To provide the Service on our behalf; To perform Service-related services; or To assist us in analyzing how our Service is used. We want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Security\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Link to Other Sites\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Children\'s Privacy\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do the necessary actions.\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Changes to This Privacy Policy\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. This policy is effective as of 2022-01-24\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      Text(
                        'Contact Us\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at alcheringa@litg.ac.in.\n',
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
