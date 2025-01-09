import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/activity_pages/widgets/competition_card.dart';
import 'package:alcheringa/Screens/activity_pages/widgets/header.dart';

class CompetitionsWidget extends StatefulWidget {
  @override
  State<CompetitionsWidget> createState() => _CompetitionsWidgetState();
}

class _CompetitionsWidgetState extends State<CompetitionsWidget> {
  late List<EventDetail> competitionsEvents = [];
  late Map<String, List<EventDetail>> categorizedEvents = {};
  late List<String> categoryKeys = [];
  String selectedType = "ALL";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    competitionsEvents = Provider.of<ViewModelMain>(context, listen: false)
        .allEvents
        .where((event) => event.category == "Competitions")
        .toList();


    categorizedEvents = {};
    for (var event in competitionsEvents) {
      if (categorizedEvents.containsKey(event.type)) {
        categorizedEvents[event.type]!.add(event);
      } else {
        categorizedEvents[event.type] = [event];
      }
    }


    categoryKeys = ["ALL", ...categorizedEvents.keys];
  }

  @override
  Widget build(BuildContext context) {
    List<String> displayedKeys = selectedType == "ALL"
        ? categoryKeys.sublist(1) 
        : [selectedType];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: DropdownButtonFormField<String>(
              value: selectedType,
              style: const TextStyle(
                fontFamily: 'Game_Tape',
                fontSize: 20.0,
                color: Color(0xFFFFF1E8),
              ),
              items: categoryKeys
                  .map(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              dropdownColor: const Color(0xFF1D2B53),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                fillColor: const Color(0xFF1D2B53),
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.zero,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 2),
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          
          Expanded(
            child: ListView.builder(
              itemCount: displayedKeys.length,
              itemBuilder: (BuildContext context, int index) {
                String key = displayedKeys[index];
                final List<EventDetail> eventList = categorizedEvents[key]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderTitle(type: key),
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 1),
                        itemCount: (eventList.length / 2).ceil(),
                        itemBuilder: (BuildContext context, int pageIndex) {
                          final int startIndex = pageIndex * 2;
                          final List<EventDetail> currentPageEvents =
                              eventList.skip(startIndex).take(2).toList();

                          return Column(
                            children: currentPageEvents
                                .map(
                                  (event) => Expanded(
                                    child: CompetitionCard(event: event),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
