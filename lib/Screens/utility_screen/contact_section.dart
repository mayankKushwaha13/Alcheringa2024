import 'package:flutter/material.dart';

class ContactSection extends StatefulWidget {
  @override
  _ContactSectionState createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  String selectedCategory = "";

  // Sample data for each category
  final Map<String, List<String>> contactData = {
    'Medicine': ['1234567890', '0987654321', '1122334455'],
    'Transport': ['5566778899', '6677889900', '7788990011'],
    'Admin': ['2233445566', '3344556677', '4455667788'],
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
                imagePath: 'assets/images/medicine.png',
                isSelected: selectedCategory == 'Medicine',
                onTap: () => setState(() {
                  selectedCategory = selectedCategory == 'Medicine' ? '' : 'Medicine';
                }),
                label: 'Medicine',
                showLabel: selectedCategory.isEmpty,
              ),
              const SizedBox(width: 30),
              CategoryButton(
                imagePath: 'assets/images/transport.png',
                isSelected: selectedCategory == 'Transport',
                onTap: () => setState(() {
                  selectedCategory = selectedCategory == 'Transport' ? '' : 'Transport';
                }),
                label: 'Transport',
                showLabel: selectedCategory.isEmpty,
              ),
              const SizedBox(width: 30),
              CategoryButton(
                imagePath: 'assets/images/admin.png',
                isSelected: selectedCategory == 'Admin',
                onTap: () => setState(() {
                  selectedCategory = selectedCategory == 'Admin' ? '' : 'Admin';
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
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final bool showLabel;

  const CategoryButton({
    required this.imagePath,
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
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.amber : Colors.transparent,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          if (showLabel)
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

// Number Box Widget
class NumberBox extends StatelessWidget {
  final String number;

  const NumberBox({required this.number});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Calling $number');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        width: 208,
        height: 75,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/number_box.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontFamily: 'Game_Tape',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              height: 1.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
