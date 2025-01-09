
class sponsorModel{
  final String title;
  final String imageurl;

  sponsorModel({
    required this.title,
    required this.imageurl,
  });
  factory sponsorModel.fromMap(Map<String, dynamic> map) {
    return sponsorModel(
      title: map['title'] ?? 'No Title',
      imageurl: map['imageurl'] ?? 'No Body',

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageurl': imageurl,
        };
  }

}


