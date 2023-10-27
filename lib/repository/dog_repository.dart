import 'dart:convert';

import 'package:deliveristo_test/constans/api_enpoints.dart';
import 'package:deliveristo_test/models/breed.dart';
import 'package:deliveristo_test/models/breed_detail.dart';
import 'package:http/http.dart' as http;

class DogRepository {
  static final DogRepository _dogRepository = DogRepository._internal();
  List<BreedDetail>? _breedData;
  List<BreedDetail> get breedDetail => _breedData ?? [];
  factory DogRepository() {
    return _dogRepository;
  }
  DogRepository._internal();

  Future<http.Response> getAllBreeds() async {
    final data = await http.get(Uri.parse(Endpoints.getAllBreedsUrl));
    // initilize the breed data
    final breedsData = Breed.fromJson(jsonDecode(data.body));
    List<BreedDetail> breeds = [];
    breedsData.breeds.forEach((key, value) {
      List<SubBreed> subbreed = [];

      value.forEach((item) {
        final sub = SubBreed(name: item);
        subbreed.add(sub);
      });

      breeds.add(BreedDetail(name: key, subbreed: subbreed));
    });
    _breedData = breeds;
    return data;
  }

  Future<http.Response> getRandomImageOfBreed({required String breedName}) async {
    final http.Response data;
    final url = '${Endpoints.baseUrl}${Endpoints.breed}/$breedName/${Endpoints.randomImage}';
    data = await http.get(Uri.parse(url));
    return data;
  }

  Future<http.Response> getRandomImageOfSubBreed({required String breedName, required String subBreed}) async {
    final http.Response data;
    data = await http
        .get(Uri.parse('${Endpoints.baseUrl}${Endpoints.breed}/$breedName/$subBreed/${Endpoints.randomImage}'));

    return data;
  }

  Future<http.Response> getImageListOfBreed({required String breedName}) async {
    final data = await http.get(Uri.parse('${Endpoints.baseUrl}${Endpoints.breed}/$breedName/${Endpoints.imageList}'));
    return data;
  }

  Future<http.Response> getImageListOfSubBreed({required String breedName, required String subBreed}) async {
    final data =
        await http.get(Uri.parse('${Endpoints.baseUrl}${Endpoints.breed}/$breedName/$subBreed/${Endpoints.imageList}'));
    return data;
  }
}
