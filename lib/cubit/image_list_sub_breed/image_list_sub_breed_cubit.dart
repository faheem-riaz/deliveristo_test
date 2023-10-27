import 'dart:convert';

import 'package:deliveristo_test/models/image_list_by_breed.dart';
import 'package:deliveristo_test/repository/dog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_list_sub_breed_state.dart';

class ImageListSubBreedCubit extends Cubit<ImageListSubBreedState> {
  final DogRepository _dogRepository = DogRepository();
  ImageListSubBreedCubit() : super(ImageListSubBreedInitial());

  Future<void> getSubBreedImage({required String breed, required String subBreed}) async {
    emit(ImageListSubBreedLoading());
    final response = await _dogRepository.getImageListOfSubBreed(breedName: breed, subBreed: subBreed);
    final subBreedData = ImageListByBreedModel.fromJson(jsonDecode(response.body));

    emit(SubBreedData(subBreedData: subBreedData));
  }
}
