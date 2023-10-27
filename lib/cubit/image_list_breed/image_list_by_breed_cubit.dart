import 'dart:convert';

import 'package:deliveristo_test/models/breed_image.dart';
import 'package:deliveristo_test/models/image_list_by_breed.dart';
import 'package:deliveristo_test/repository/dog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_list_by_breed_state.dart';

class ImageListByBreedCubit extends Cubit<ImageListByBreedState> {
  final DogRepository _repository = DogRepository();
  ImageListByBreedCubit() : super(ImageListByBreedInitial());

  Future<void> getBreedData(String breedName) async {
    emit(LoadingBreedList());
    await _getBreedDataImpl(breedName);
  }

  Future<void> _getBreedDataImpl(String breedName) async {
    final breedData = _repository.breedDetail.where((element) => element.name == breedName).firstOrNull;

    if (breedData != null && breedData.subbreed.isNotEmpty) {
      ImageListByBreed imageListByBreed = ImageListByBreed.empty();
      List<BreedImage> subBreedImages = [];
      await Future.forEach(
        breedData.subbreed,
        (subBreed) async {
          final response = await _repository.getRandomImageOfSubBreed(
            breedName: breedName,
            subBreed: subBreed.name,
          );
          final imageData = BreedImage.fromJson(jsonDecode(response.body));
          imageData.breedName = subBreed.name;
          subBreedImages.add(imageData);
        },
      );

      imageListByBreed = ImageListByBreed(images: subBreedImages, breedName: breedName);
      emit(BreedData(imageListByBreed: imageListByBreed));
    } else {
      final response = await _repository.getImageListOfBreed(breedName: breedName);
      final imageData = ImageListByBreedModel.fromJson(jsonDecode(response.body));
      emit(BreedDataWithNoSubBreeds(imageListByBreed: imageData));
    }
  }
}
