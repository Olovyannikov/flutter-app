part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationError extends LocationState {
  const LocationError();
}

class LocationLoaded extends LocationState {
  final double longitude;
  final double latitude;

  @override
  List<Object> get props => [latitude, longitude];

  const LocationLoaded({required this.latitude, required this.longitude});
}
