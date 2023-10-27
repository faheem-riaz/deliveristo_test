import 'package:deliveristo_test/cubit/dashboard/breed_cubit.dart';
import 'package:deliveristo_test/cubit/image_list_breed/image_list_by_breed_cubit.dart';
import 'package:deliveristo_test/cubit/image_list_sub_breed/image_list_sub_breed_cubit.dart';
import 'package:deliveristo_test/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const DogApp());
}

class DogApp extends StatelessWidget {
  const DogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BreedCubit>(
          create: (BuildContext context) => BreedCubit(),
        ),
        BlocProvider<ImageListByBreedCubit>(
          create: (BuildContext context) => ImageListByBreedCubit(),
        ),
        BlocProvider<ImageListSubBreedCubit>(
          create: (BuildContext context) => ImageListSubBreedCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
        ),
        home: const Dashboard(),
      ),
    );
  }
}
