import 'package:alcheringa/Model/own_time.dart';
import 'package:flutter/material.dart';

class EventDescriptionWidget extends StatelessWidget {
  const EventDescriptionWidget({
    super.key,
    required this.imgurl,
    required this.title,
    required this.venue,
    required this.date,
    required this.description,
    required this.category,
  });
  final String imgurl;
  final String title;
  final String venue;
  final OwnTime date;
  final String description;
  final String category;

  @override
  Widget build(BuildContext context) {
    String hours =
        date.hours > 12 ? (date.hours - 12).toString() : date.hours.toString();
    String time = "${date.date.toString()} Feb, $hours";
    date.hours >= 12 ? time += " PM" : time += " AM";
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.white)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image(
                image: NetworkImage(imgurl),
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    Text(
                      venue,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
