part of 'breed_cubit.dart';

class BreedState {}

class BreedInitial extends BreedState {}

class Loading extends BreedState {}

class AllBreeds extends BreedState {
  final List<BreedDetail> breeds;
  AllBreeds({required this.breeds});
}

class NoBreeds extends BreedState {}

class NetwrokError extends BreedState {
  final String message;
  NetwrokError({required this.message});
}
