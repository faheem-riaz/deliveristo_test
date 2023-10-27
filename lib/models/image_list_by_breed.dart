import 'package:deliveristo_test/models/breed_image.dart';

class ImageListByBreed {
  List<BreedImage> images;
  String breedName;
  ImageListByBreed({required this.images, required this.breedName});

  factory ImageListByBreed.empty() {
    return ImageListByBreed(images: [], breedName: '');
  }
}

class ImageListByBreedModel {
  List<dynamic> images;
  String status;

  ImageListByBreedModel({required this.images, required this.status});

  factory ImageListByBreedModel.fromJson(Map<String, dynamic> json) {
    return ImageListByBreedModel(images: json['message'], status: json['status']);
  }
}
