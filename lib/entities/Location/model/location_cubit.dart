import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission != LocationPermission.deniedForever ||
        permission != LocationPermission.denied) {
      emit(LocationLoading());

      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high
        );

        emit(LocationLoaded(
            latitude: position.latitude, longitude: position.longitude));
      } catch (error) {
        emit(LocationError());
        print(error.toString());
      }
    }
  }
}
