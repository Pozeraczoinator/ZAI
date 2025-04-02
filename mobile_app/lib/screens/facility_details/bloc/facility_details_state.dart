part of 'facility_details_bloc.dart';

enum FacilityDetailsLoadingStatus { loading, loaded, error }

enum RatingLoadingStatus { idle, adding, success, error }

class FacilityDetailsState extends Equatable {
  final FacilityDetailsLoadingStatus status;
  final RatingLoadingStatus ratingStatus;
  final FacilityData? facility;
  final List<SportFacility> userFacilities;

  const FacilityDetailsState(
      {this.status = FacilityDetailsLoadingStatus.loading,
      this.ratingStatus = RatingLoadingStatus.idle,
      this.facility,
      this.userFacilities = const []});

  FacilityDetailsState copyWith(
      {FacilityDetailsLoadingStatus? status,
      RatingLoadingStatus? ratingStatus,
      FacilityData? facility,
      List<SportFacility>? userFacilities}) {
    return FacilityDetailsState(
        status: status ?? this.status,
        ratingStatus: ratingStatus ?? this.ratingStatus,
        facility: facility ?? this.facility,
        userFacilities: userFacilities ?? this.userFacilities);
  }

  @override
  List<Object?> get props => [status, facility, ratingStatus, userFacilities];
}
