import 'package:deliveristo_test/cubit/image_list_sub_breed/image_list_sub_breed_cubit.dart';
import 'package:deliveristo_test/widgets/app_appbar.dart';
import 'package:deliveristo_test/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageListSubBreed extends StatefulWidget {
  final String breedName;
  final String subSbreed;
  const ImageListSubBreed({super.key, required this.subSbreed, required this.breedName});

  @override
  State<ImageListSubBreed> createState() => _ImageListSubBreedState();
}

class _ImageListSubBreedState extends State<ImageListSubBreed> {
  final cubit = ImageListSubBreedCubit();
  @override
  void initState() {
    cubit.getSubBreedImage(breed: widget.breedName, subBreed: widget.subSbreed);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('${widget.breedName} ${widget.subSbreed}', context),
      body: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if (state is ImageListSubBreedLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SubBreedData) {
            return MasonryGridView.builder(
              itemCount: state.subBreedData.images.length,
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return AppNetworkImage(url: state.subBreedData.images[index]);
              },
            );
          } else if (state is ServerErrorImageListBySubBreed) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
