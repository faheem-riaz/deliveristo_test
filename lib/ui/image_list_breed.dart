import 'package:deliveristo_test/cubit/image_list_breed/image_list_by_breed_cubit.dart';
import 'package:deliveristo_test/ui/image_list_sub_breed.dart';
import 'package:deliveristo_test/widgets/app_appbar.dart';
import 'package:deliveristo_test/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageListByBreed extends StatefulWidget {
  final String breedName;

  const ImageListByBreed({super.key, required this.breedName});

  @override
  State<ImageListByBreed> createState() => _ImageListByBreedState();
}

class _ImageListByBreedState extends State<ImageListByBreed> {
  final cubit = ImageListByBreedCubit();
  @override
  void initState() {
    cubit.getBreedData(widget.breedName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('${widget.breedName} breed', context),
      body: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if (state is LoadingBreedList) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BreedData) {
            return MasonryGridView.builder(
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: state.imageListByBreed.images.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageListSubBreed(
                        breedName: widget.breedName,
                        subSbreed: state.imageListByBreed.images[index].breedName ?? '',
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    AppNetworkImage(
                      url: state.imageListByBreed.images[index].image,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.imageListByBreed.images[index].breedName ?? '',
                        style: const TextStyle(
                          backgroundColor: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is BreedDataWithNoSubBreeds) {
            return MasonryGridView.builder(
              itemCount: state.imageListByBreed.images.length,
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) => AppNetworkImage(
                url: state.imageListByBreed.images[index],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
