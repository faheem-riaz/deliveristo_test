import 'package:deliveristo_test/cubit/dashboard/breed_cubit.dart';
import 'package:deliveristo_test/models/breed_detail.dart';
import 'package:deliveristo_test/ui/image_list_breed.dart';
import 'package:deliveristo_test/widgets/app_appbar.dart';
import 'package:deliveristo_test/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Random Image of All Breeds', context),
      body: BlocBuilder<BreedCubit, BreedState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllBreeds) {
            return ListView.separated(
              itemBuilder: (context, index) => DogCard(breed: state.breeds[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: state.breeds.length,
            );
          } else if (state is NetwrokError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class DogCard extends StatelessWidget {
  final BreedDetail breed;
  final cubit = BreedCubit();
  DogCard({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImageListByBreed(breedName: breed.name),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: FutureBuilder(
          future: cubit.getBreedRandomImage(breed.name),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Text('Loading');
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AppNetworkImage(
                      url: snapshot.data?.image,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      breed.name,
                      style: const TextStyle(
                        backgroundColor: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
