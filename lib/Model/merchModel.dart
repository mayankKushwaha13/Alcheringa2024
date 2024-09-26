class MerchModel {
  String? name;
  String? type;
  String? price;
  String? description;
  String? image;
  bool? available;
  bool? small;
  bool? medium;
  bool? large;
  bool? extraLarge;
  bool? xxLarge;
  List<String>? images;
  String? video;
  String? smallDescription;
  String? background;
  String? merchDefault;

  MerchModel({
    this.name,
    this.type,
    this.price,
    this.description,
    this.image,
    this.available,
    this.small,
    this.medium,
    this.large,
    this.extraLarge,
    this.xxLarge,
    this.images,
    this.video,
    this.smallDescription,
    this.background,
    this.merchDefault,
  });

  // Factory method to convert Firestore document to MerchModel
  factory MerchModel.fromMap(Map<String, dynamic> data) {
    return MerchModel(
      name: data['Name'],
      type: data['Type'],
      price: data['Price'],
      description: data['Description'],
      image: data['Image'],
      available: data['Available'],
      small: data['Small'],
      medium: data['Medium'],
      large: data['Large'],
      extraLarge: data['ExtraLarge'],
      xxLarge: data['XXLarge'],
      images: List<String>.from(data['Images'] ?? []), // Handle list of images
      video: data['Video'],
      smallDescription: data['Small_Description'],
      background: data['background'],
      merchDefault: data['Merch_Default'],
    );
  }
}
