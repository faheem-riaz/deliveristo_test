import 'package:deliveristo_test/repository/dog_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DogRepository', () {
    test('getAllBreeds should return a successful response', () async {
      // Arrange
      final dogRepository = DogRepository();
      // Act
      final data = await dogRepository.getAllBreeds();
      //Assert
      final response = data.fold((l) => null, (res) => res);
      expect(response?.statusCode, 200);
    });

    test('getRandomImageOfBreed should return a successful response', () async {
      final dogRepository = DogRepository();
      const breedName = 'husky';
      final data = await dogRepository.getRandomImageOfBreed(breedName: breedName);

      final response = data.fold((l) => null, (res) => res);
      expect(response?.statusCode, 200);
    });

    test('getRandomImageOfSubBreed should return a successful response', () async {
      final dogRepository = DogRepository();
      const breedName = 'hound';
      const subBreed = 'afghan';
      final data = await dogRepository.getRandomImageOfSubBreed(breedName: breedName, subBreed: subBreed);

      final response = data.fold((l) => null, (res) => res);
      expect(response?.statusCode, 200);
    });

    test('getImageListOfBreed should return a successful response', () async {
      final dogRepository = DogRepository();
      const breedName = 'husky';
      final data = await dogRepository.getImageListOfBreed(breedName: breedName);
      final response = data.fold((l) => null, (res) => res);
      expect(response?.statusCode, 200);
    });

    test('getImageListOfSubBreed should return a successful response', () async {
      final dogRepository = DogRepository();
      const breedName = 'hound';
      const subBreed = 'afghan';
      final data = await dogRepository.getImageListOfSubBreed(breedName: breedName, subBreed: subBreed);

      final response = data.fold((l) => null, (res) => res);
      expect(response?.statusCode, 200);
    });
  });
}
