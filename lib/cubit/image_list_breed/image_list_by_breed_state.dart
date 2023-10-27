part of 'image_list_by_breed_cubit.dart';

class ImageListByBreedState {}

class ImageListByBreedInitial extends ImageListByBreedState {}

class LoadingBreedList extends ImageListByBreedState {}

class BreedData extends ImageListByBreedState {
  final ImageListByBreed imageListByBreed;
  BreedData({required this.imageListByBreed});
}

class BreedDataWithNoSubBreeds extends ImageListByBreedState {
  final ImageListByBreedModel imageListByBreed;
  BreedDataWithNoSubBreeds({required this.imageListByBreed});
}

class ServerErrorImageListByBreed extends ImageListByBreedState {
  final String message;
  ServerErrorImageListByBreed({required this.message});
}
