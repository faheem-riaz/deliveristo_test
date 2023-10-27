class BreedDetail {
  final String name;
  final List<SubBreed> subbreed;

  BreedDetail({required this.name, required this.subbreed});
}

class SubBreed {
  final String name;
  SubBreed({required this.name});
}
