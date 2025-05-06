import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/api/api_constants.dart';
import 'package:flutter_app/shared/api/index.dart';

part 'state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());

  Future<void> getImages() async {
    emit(GalleryLoading());
    List<String> images = [];
    String url = '$API_BASE_URL&image_type=photo';

    ApiInstance api = ApiInstance(url: url);
    dynamic data = await api.getData();

    List<dynamic> hitsList = data['hits'] as List;

    for (int i = 0; i < hitsList.length; i++) {
      images.add(hitsList[i]['largeImageURL']);
    }

    emit(GalleryLoaded(images: images));
  }
}
