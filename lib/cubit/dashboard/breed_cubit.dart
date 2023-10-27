import 'dart:convert';

import 'package:deliveristo_test/models/breed.dart';
import 'package:deliveristo_test/models/breed_detail.dart';
import 'package:deliveristo_test/models/breed_image.dart';
import 'package:deliveristo_test/repository/dog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'breed_state.dart';

class BreedCubit extends Cubit<BreedState> {
  final DogRepository repository = DogRepository();
  BreedCubit() : super(BreedInitial()) {
    getBreeds();
  }

  Future<void> getBreeds() async {
    emit(Loading());
    try {
      await _getBreedsImpl();
    } on Exception catch (e) {
      emit(NetwrokError(message: e.toString()));
    }
  }

  Future<BreedImage> getBreedRandomImage(String breedName) async {
    try {
      final response = await repository.getRandomImageOfBreed(breedName: breedName);
      final breedsData = BreedImage.fromJson(jsonDecode(response.body));
      return breedsData;
    } on Exception {
      return BreedImage(image: '', status: 'failed');
    }
  }

  Future<void> _getBreedsImpl() async {
    final response = await repository.getAllBreeds();
    final breedsData = Breed.fromJson(jsonDecode(response.body));
    List<BreedDetail> breeds = [];
    breedsData.breeds.forEach((key, value) {
      List<SubBreed> subbreed = [];

      value.forEach((item) {
        final sub = SubBreed(name: item);
        subbreed.add(sub);
      });

      breeds.add(BreedDetail(name: key, subbreed: subbreed));
    });
    if (breeds.isEmpty) {
      emit(NoBreeds());
      return;
    }
    emit(AllBreeds(breeds: breeds));
  }
}
