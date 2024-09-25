
class EventLive{
  late EventDetail eventDetail;
  bool isLive = false;


  EventLive({
    required this.eventDetail,
    required this.isLive
  });
}


class EventDetail{
  String artist = "";
  String category = "";
  OwnTime starttime = OwnTime(date: 0 , hours: 0, min: 0);
  String mode = "Offline";
  String imgurl = "";
  int durationInMin = 60;
  List<String> genre = [];
  String descriptionEvent = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.";
  String venue = "";
  String type = "";
  String joinlink = "https://www.alcheringa.in";
  String reglink="https://www.alcheringa.in";
  bool stream = false;

  EventDetail({
    required this.artist,
    required this.category,
    required this.starttime,
    required this.imgurl,
    required this.durationInMin,
    required this.genre,
    required this.descriptionEvent,
    required this.venue,
    required this.type,
    required this.joinlink,
    required this.reglink,
    required this.stream,
    required this.mode,
  });

  factory EventDetail.fromMap(Map<String, dynamic> data) {

    return EventDetail(
      artist: data['artist'],
      category: data['category'],
      starttime: OwnTime.fromMap(data['starttime']),
      imgurl: data['imgurl'],
      durationInMin: data['durationInMin'],
      genre: List<String>.from(data['genre']),
      descriptionEvent: data['descriptionEvent'],
      venue: data['venue'],
      type: data['type'],
      joinlink: data['joinlink'],
      reglink: data['reglink'],
      mode: data['mode'],
      stream: data['stream'],
    );
  }
}

class OwnTime{
  int date = 0;
  int hours = 0;
  int min = 0;

  OwnTime({
    required this.date,
    required this.hours,
    required this.min,
  });
  
  factory OwnTime.fromMap(Map<String, dynamic> data){
    return OwnTime(
      date: data['date'], 
      hours: data['hours'], 
      min: data['min'],
    );
  }
}