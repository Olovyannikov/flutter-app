import 'package:flutter/material.dart';
import 'package:flutter_app/entities/Gallery/model/cubit.dart';
import 'package:flutter_app/screens/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryCubit>(
      create: (context) => GalleryCubit()..getImages() ,
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: HomeScreen()
      ),
    );
  }
}
