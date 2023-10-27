part of 'image_list_sub_breed_cubit.dart';

class ImageListSubBreedState {}

class ImageListSubBreedInitial extends ImageListSubBreedState {}

class ImageListSubBreedLoading extends ImageListSubBreedState {}

class SubBreedData extends ImageListSubBreedState {
  final ImageListByBreedModel subBreedData;
  SubBreedData({required this.subBreedData});
}
