import 'package:flutter/material.dart';

class FaqSection extends StatefulWidget {
  @override
  _FaqSectionState createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  List<FaqItem> _faqItems = [
    FaqItem(
      question: 'Where can I buy the executive pass?',
      answer:
      'You can buy the executive pass from the Alcheringa website or at the venue.',
    ),
    FaqItem(
      question: 'Can I update my event schedule after registering?',
      answer:
      'Yes, you can update your event schedule by logging into your Alcheringa account.',
    ),
    FaqItem(
      question: 'What if I have a query about my registration?',
      answer:
      'You can contact the Alcheringa team at support@alcheringa.in or call +91 0000000022.',
    ),
    FaqItem(
      question: 'Where can I find the event map?',
      answer:
      'The event map will be available on the Alcheringa website and at the venue.',
    ),
    FaqItem(
      question: 'Where can I park my vehicle?',
      answer:
      'Parking facilities are available at the venue. Please follow the designated parking areas.',
    ),
  ];

  Set<int> _expandedIndices = {}; // Track expanded questions

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/faq_title.png',
              width: 106,
              height: 58,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                ..._faqItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final faq = entry.value;
                  final isExpanded = _expandedIndices.contains(index);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question Box
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isExpanded) {
                              _expandedIndices.remove(index); // Collapse
                            } else {
                              _expandedIndices.add(index); // Expand
                            }
                          });
                        },
                        child: Container(
                          width: 258,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/faq_box.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              faq.question,
                              style: TextStyle(
                                fontFamily: 'Game_Tape',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.15,
                                color: Colors.white,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ),

                      // Answer Box
                      if (isExpanded)
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          alignment: Alignment.centerRight, // Align to the right
                          child: Container(
                            width: 266,
                            height: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/faq_box2.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                faq.answer,
                                style: TextStyle(
                                  fontFamily: 'Game_Tape',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 16.06 / 16,
                                  letterSpacing: 0.15,
                                  color: Colors.white,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}
