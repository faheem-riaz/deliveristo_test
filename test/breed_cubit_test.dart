import 'package:deliveristo_test/cubit/dashboard/breed_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BreedCubit', () {
    test('getBreeds() should return a successful response and update the state correctly', () async {
      // Create a BreedCubit object.
      final breedCubit = BreedCubit();

      // Call the getBreeds() method.
      await breedCubit.getBreeds();

      // Verify that the BreedCubit state is updated correctly.
      expect(breedCubit.state, isInstanceOf<AllBreeds>());
    });
  });
}
