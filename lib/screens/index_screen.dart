import 'package:flutter/material.dart';
import 'package:flutter_app/entities/Bird/model/Bird.cubit.dart';
import 'package:flutter_app/entities/Bird/model/Bird.model.dart';
import 'package:flutter_app/entities/Location/model/location_cubit.dart';
import 'package:flutter_app/screens/add_bird_screen.dart';
import 'package:flutter_app/screens/bird_info_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  final MapController _mapController = MapController();

  Future<void> _pickImageAndCreatePost({
    required LatLng position,
    required BuildContext context,
  }) async {
    File? image;
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddBirdScreen(position: position, image: image),
        ),
      );
    } else {
      print('User didnt pick image');
    }
  }

  List<Marker> _buildMarkers(BuildContext context, List<BirdModel> birdPosts) {
    List<Marker> markers = [];

    birdPosts.forEach((post) {
      markers.add(
        Marker(
          width: 55,
          height: 55,
          point: LatLng(post.latitude, post.longitude),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BirdInfoScreen(birdModel: post)));
            },
            child: Image.asset('assets/bird-icon.png'),
          ),
          alignment: Alignment.center
        ),
      );
    });

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationCubit, LocationState>(
        listener: (prev, current) {
          if (current is LocationLoaded) {
            _mapController.move(
              LatLng(current.latitude, current.longitude),
              14,
            );
          }

          if (current is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red.withOpacity(0.6),
                content: Text('Error'),
              ),
            );
          }
        },
        child: BlocBuilder<BirdPostCubit, BirdPostState>(
          buildWhen: (prevState, currentState) => (prevState.status != currentState.status),
          builder: (context, birdPostState) {
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                onLongPress: (_, position) {
                  _pickImageAndCreatePost(position: position, context: context);

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => AddBirdScreen(position: position),
                  //   ),
                  // );
                },
                initialCenter: LatLng(0, 0),
                initialZoom: 15.3,
                maxZoom: 17,
                minZoom: 3.5,
              ),
              children: [
                TileLayer(
                  retinaMode: true,
                  subdomains: ['a', 'b', 'c'],
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: _buildMarkers(context, birdPostState.birdPosts),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

//
