import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Screens/event_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class SuggestionCard extends StatefulWidget {
  final EventDetail event;
  const SuggestionCard({super.key, required this.event});

  @override
  State<SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    String month = widget.event.starttime.date >= 31 ? 'Jan' : 'Feb';
    String eventTime = '${widget.event.starttime.date} $month';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailPage(event: widget.event)));
        },
        child: Stack(
          children: [
            Container(
              width: mq.width,
              height: mq.width * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/event_card_bg.png'),
                  fit: BoxFit.fill
                )
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.event.iconURL,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/basketball.png'
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8),
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
                            overflow: TextOverflow.ellipsis,
                          ),
                          Flexible(
                            child: Text(
                              widget.event.descriptionShort,
                              style: TextStyle(
                                  color: Color(0xFFFF77A8),
                                  fontSize: 14,
                                  fontFamily: 'Game_Tape',
                                  letterSpacing: .15),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${eventTime}, ${widget.event.starttime.hours > 12 ? widget.event.starttime.hours - 12 : widget.event.starttime.hours} ${widget.event.starttime.hours > 12 ? "PM" : "AM"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFFFF1E8),
                                  fontSize: 16,
                                  fontFamily: 'Game_Tape',
                                  fontWeight: FontWeight.w400,
                                  height: 1.71,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "  |",
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
                              Expanded(
                                child: SizedBox(
                                  height: 30, // Set a fixed height
                                  child: Marquee(
                                    text: widget.event.venue,
                                    style: TextStyle(
                                      color: Color(0xFFFFF1E8),
                                      fontSize: 16,
                                      fontFamily: 'Game_Tape',
                                      fontWeight: FontWeight.w400,
                                      height: 1.71,
                                      letterSpacing: 0.15,
                                    ),
                                    scrollAxis: Axis.horizontal,
                                    blankSpace: 30.0,
                                    velocity: 20.0,
                                    startPadding: 10.0,
                                    pauseAfterRound: Duration(seconds: 1),
                                    showFadingOnlyWhenScrolling: true,
                                    fadingEdgeStartFraction: 0.1,
                                    fadingEdgeEndFraction: 0.1,
                                  ),
                                ),
                              ),
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
