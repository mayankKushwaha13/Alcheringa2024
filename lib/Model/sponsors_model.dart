
class sponsorModel{
  final String title;
  final String imageurl;
  final bool heading;

  sponsorModel({
    required this.title,
    required this.imageurl,
    required this.heading
  });
  factory sponsorModel.fromMap(Map<String, dynamic> map) {
    return sponsorModel(
      title: map['title'] ?? 'No Title',
      imageurl: map['imageurl'] ?? 'No Body',
      heading: map['heading']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageurl': imageurl,
    };
  }

}


