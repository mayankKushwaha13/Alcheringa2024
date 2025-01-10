import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Screens/event_detail_page.dart';
import 'package:flutter/material.dart';

class CompetitionCard extends StatefulWidget {
  final EventDetail event;

  const CompetitionCard({required this.event, super.key});

  @override
  State<CompetitionCard> createState() => _CompetitionCardState();
}

class _CompetitionCardState extends State<CompetitionCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailPage(event: widget.event)));
        },
        child: Stack(
          children: [
            Image.asset(
              "assets/images/event_card_bg.png",
              fit: BoxFit.fill,
              width: mq.width,
              height: mq.width * 0.4,
            ),
            Container(
              width: mq.width,
              height: mq.width * 0.4,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // widget.event.iconURL==null || widget.event.iconURL==""
                  // ?Image.asset( "assets/images/basketball.png",scale: 1.2,)
                  // :Image.network(widget.event.iconURL),
                  Image.asset(
                    "assets/images/basketball.png",
                    scale: 1.2,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.event.artist,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.15,
                                fontFamily: 'Brick_Pixel'),
                          ),
                          Flexible(
                            child: Text(
                              widget.event.descriptionEvent,
                              style: TextStyle(
                                  color: Color(0xFFFF77A8), fontSize: 14, fontFamily: 'Game_Tape', letterSpacing: .15),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${widget.event.starttime.date} Jan, ${widget.event.starttime.hours > 12 ? widget.event.starttime.hours - 12 : widget.event.starttime.hours} ${widget.event.starttime.hours > 12 ? "PM" : "AM"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFFFF1E8),
                                  fontSize: 16,
                                  fontFamily: 'Game_Tape',
                                  fontWeight: FontWeight.w400,
                                  height: 1.71,
                                ),
                              ),
                              Text(
                                "|",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFFFFF1E8),
                                  fontSize: 16,
                                  fontFamily: 'Game_Tape',
                                  fontWeight: FontWeight.w400,
                                  height: 1.71,
                                  letterSpacing: 0.15,
                                ),
                              ),
                              Text(
                                widget.event.venue,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFFFFF1E8),
                                  fontSize: 16,
                                  fontFamily: 'Game_Tape',
                                  fontWeight: FontWeight.w400,
                                  height: 1.71,
                                  letterSpacing: 0.15,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
