import 'package:flutter/material.dart';
import 'package:flutter_app/entities/Gallery/model/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryCubit, GalleryState>(
      builder: (context, state) {
        if (state is GalleryLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is GalleryLoaded) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: GridView.builder(
                  itemCount: state.images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemBuilder: (_, index) {
                    return Image.network(
                      state.images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
