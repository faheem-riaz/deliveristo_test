class BreedImage {
  String image;
  String status;
  String? breedName;

  BreedImage({required this.image, required this.status});

  factory BreedImage.fromJson(Map<String, dynamic> json) {
    return BreedImage(image: json['message'], status: json['status']);
  }
}
