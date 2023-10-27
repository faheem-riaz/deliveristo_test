import 'package:deliveristo_test/cubit/dashboard/breed_cubit.dart';
import 'package:deliveristo_test/cubit/image_list_breed/image_list_by_breed_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ImageListByBreedCubit', () {
    test('getBreedData() should return a successful response and update the state correctly', () async {
      // Create an ImageListByBreedCubit object.
      final imageListByBreedCubit = ImageListByBreedCubit();

      // Call the getBreedData() method.
      await imageListByBreedCubit.getBreedData('husky');

      // Verify that the ImageListByBreedCubit state is updated correctly.
      expect(imageListByBreedCubit.state, isInstanceOf<BreedDataWithNoSubBreeds>());
    });

    test('getBreedData() should return a successful response and update the state correctly with subbreeds', () async {
      // Create an ImageListByBreedCubit object.
      final imageListByBreedCubit = ImageListByBreedCubit();
      final breedCubit = BreedCubit();

      // Call the getBreedData() method.
      await breedCubit.getBreeds();
      await imageListByBreedCubit.getBreedData('hound');

      // Verify that the ImageListByBreedCubit state is updated correctly.
      expect(imageListByBreedCubit.state, isInstanceOf<BreedData>());
    });
  });
}
