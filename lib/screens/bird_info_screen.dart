import 'package:flutter/material.dart';
import 'package:flutter_app/entities/Bird/model/Bird.cubit.dart';
import 'package:flutter_app/entities/Bird/model/Bird.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirdInfoScreen extends StatelessWidget {
  final BirdModel birdModel;

  const BirdInfoScreen({required this.birdModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(birdModel.birdName!)),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(birdModel.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              birdModel.birdName!,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 4),
            Text(
              birdModel.birdDescription!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 4),
            TextButton(onPressed: () {
              context.read<BirdPostCubit>().removeBirdPost(birdModel);
              Navigator.of(context).pop();
            }, child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
