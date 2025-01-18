import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactSection extends StatefulWidget {
  @override
  _ContactSectionState createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  String selectedCategory = "";

  // Sample data for each category
  final Map<String, List<String>> contactData = {
    'MEDICINE': ['0361-2583813', '0361-2585555', '0361-2586666'],
    'TRANSPORT': ['8486668456', '8638289730', '6001440472'],
    'ADMIN': ['8812923115', '9707049872', '8319855908'],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Ensure content is centered
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/contacts.png',
              width: 173,
              height: 42,
            ),
          ),
          const SizedBox(height: 20),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center buttons horizontally
            children: [
              CategoryButton(
                backgroundImagePath: selectedCategory == 'MEDICINE'
                    ? 'assets/images/box_clicked.png'
                    : 'assets/images/box_not_clicked.png',
                iconImagePath: 'assets/images/medicine_icon.png',
                isSelected: selectedCategory == 'MEDICINE',
                onTap: () => setState(() {
                  selectedCategory = selectedCategory == 'MEDICINE' ? '' : 'MEDICINE';
                }),
                label: 'MEDICINE',
                showLabel: selectedCategory.isEmpty,
              ),
              const SizedBox(width: 30),
              CategoryButton(
                backgroundImagePath: selectedCategory == 'TRANSPORT'
                    ? 'assets/images/box_clicked.png'
                    : 'assets/images/box_not_clicked.png',
                iconImagePath: 'assets/images/transport_icon.png',
                isSelected: selectedCategory == 'Transport',
                onTap: () => setState(() {
                  selectedCategory = selectedCategory == 'TRANSPORT' ? '' : 'TRANSPORT';
                }),
                label: 'TRANSPORT',
                showLabel: selectedCategory.isEmpty,
              ),
              const SizedBox(width: 30),
              CategoryButton(
                backgroundImagePath: selectedCategory == 'ADMIN'
                    ? 'assets/images/box_clicked.png'
                    : 'assets/images/box_not_clicked.png',
                iconImagePath: 'assets/images/admin_icon.png',
                isSelected: selectedCategory == 'ADMIN',
                onTap: () => setState(() {
                  selectedCategory = selectedCategory == 'ADMIN' ? '' : 'ADMIN';
                }),
                label: 'Admin',
                showLabel: selectedCategory.isEmpty,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Display Box
          if (selectedCategory.isNotEmpty)
            Center(
              child: Container(
                width: 258,
                height: 354,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/contact_box.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Title
                    Text(
                      selectedCategory,
                      style: const TextStyle(
                        fontFamily: 'Game_Tape',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        letterSpacing: 0.15,
                        //decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Numbers
                    Expanded(
                      child: ListView.builder(
                        itemCount: contactData[selectedCategory]!.length,
                        itemBuilder: (context, index) {
                          final number = contactData[selectedCategory]![index];
                          return NumberBox(number: number);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Category Button Widget
class CategoryButton extends StatelessWidget {
  final String backgroundImagePath;
  final String iconImagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final bool showLabel;

  const CategoryButton({
    required this.backgroundImagePath,
    required this.iconImagePath,
    required this.isSelected,
    required this.onTap,
    required this.label,
    required this.showLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                backgroundImagePath,
                width: 72,
                height: 72,
              ),
              Image.asset(
                iconImagePath,
                width: 68,
                height: 68,
              ),
            ],
          ),
          const SizedBox(height: 5),
          if (showLabel)
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Game_Tape',
              ),
            ),
        ],
      ),
    );
  }
}

class NumberBox extends StatelessWidget {
  final String number;

  const NumberBox({required this.number});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final status = await Permission.phone.request();
    if (status.isGranted) {
      final Uri callUri = Uri.parse("tel://$phoneNumber");
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        throw 'Could not launch phone dialer';
      }
    } else {
      print('Permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: 208,
        height: 75,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/number_box.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      fontFamily: 'Game_Tape',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final phoneNumber = '$number';
                await _makePhoneCall(phoneNumber);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/call_button.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
