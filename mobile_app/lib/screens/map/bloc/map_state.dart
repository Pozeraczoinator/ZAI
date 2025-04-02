part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isLoaded;
  final List<FacilityCoords> cords;
  final Coordinates userLocation;
  const MapState({
    this.isLoaded = false,
    this.cords = const [],
    this.userLocation = AppConsts.centerCoords,
  });

  MapState copyWith(
      {bool? isLoaded,
      List<FacilityCoords>? cords,
      Coordinates? userLocation}) {
    return MapState(
      isLoaded: isLoaded ?? this.isLoaded,
      cords: cords ?? this.cords,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  @override
  List<Object?> get props => [isLoaded, cords, userLocation];
}
