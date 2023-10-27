import 'dart:convert';

import 'package:deliveristo_test/core/contants/api_enpoints.dart';
import 'package:deliveristo_test/core/error/server_error.dart';
import 'package:deliveristo_test/models/breed.dart';
import 'package:deliveristo_test/models/breed_detail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class DogRepository {
  static final DogRepository _dogRepository = DogRepository._internal();
  List<BreedDetail>? _breedData;
  List<BreedDetail> get breedDetail => _breedData ?? [];
  factory DogRepository() {
    return _dogRepository;
  }
  DogRepository._internal();

  Future<Either<APIServerError, http.Response>> getAllBreeds() async {
    try {
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
      if (data.statusCode == 404) {
        return Left(APIServerError(message: 'not found'));
      }
      return Right(data);
    } on Exception catch (e) {
      return Left(APIServerError(message: e.toString()));
    }
  }

  Future<Either<APIServerError, http.Response>> getRandomImageOfBreed({required String breedName}) async {
    try {
      final http.Response data;
      final url = '${Endpoints.baseUrl}${Endpoints.breed}/$breedName/${Endpoints.randomImage}';
      data = await http.get(Uri.parse(url));
      if (data.statusCode == 404) {
        return Left(APIServerError(message: 'not found'));
      }
      return Right(data);
    } on Exception catch (e) {
      return Left(APIServerError(message: e.toString()));
    }
  }

  Future<Either<APIServerError, http.Response>> getRandomImageOfSubBreed(
      {required String breedName, required String subBreed}) async {
    try {
      final http.Response data;
      data = await http
          .get(Uri.parse('${Endpoints.baseUrl}${Endpoints.breed}/$breedName/$subBreed/${Endpoints.randomImage}'));
      if (data.statusCode == 404) {
        return Left(APIServerError(message: 'not found'));
      }
      return Right(data);
    } on Exception catch (e) {
      return Left(APIServerError(message: e.toString()));
    }
  }

  Future<Either<APIServerError, http.Response>> getImageListOfBreed({required String breedName}) async {
    try {
      final data =
          await http.get(Uri.parse('${Endpoints.baseUrl}${Endpoints.breed}/$breedName/${Endpoints.imageList}'));
      if (data.statusCode == 404) {
        return Left(APIServerError(message: 'not found'));
      }
      return Right(data);
    } on Exception catch (e) {
      return Left(APIServerError(message: e.toString()));
    }
  }

  Future<Either<APIServerError, http.Response>> getImageListOfSubBreed(
      {required String breedName, required String subBreed}) async {
    try {
      final data = await http
          .get(Uri.parse('${Endpoints.baseUrl}${Endpoints.breed}/$breedName/$subBreed/${Endpoints.imageList}'));
      if (data.statusCode == 404) {
        return Left(APIServerError(message: 'not found'));
      }
      return Right(data);
    } on Exception catch (e) {
      return Left(APIServerError(message: e.toString()));
    }
  }
}
