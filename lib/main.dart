import 'package:flutter/material.dart';
import 'package:flutter_app/entities/Bird/model/Bird.cubit.dart';
import 'package:flutter_app/entities/Location/model/location_cubit.dart';
import 'package:flutter_app/screens/index_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(create: (context) => LocationCubit()..getLocation()),
        BlocProvider<BirdPostCubit>(create: (context) => BirdPostCubit()..loadPosts()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF334257),
          colorScheme: ColorScheme.light().copyWith(
            primary: Color(0xFF548CA8),
            secondary: Color(0xFF96BAFF),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
