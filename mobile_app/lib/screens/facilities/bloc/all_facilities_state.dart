part of 'all_facilities_bloc.dart';

enum AllFacilitiesStatus { loading, loaded, error }

class AllFacilitiesState extends Equatable {
  final AllFacilitiesStatus status;
  final List<SportFacility> facilities;
  const AllFacilitiesState(
      {this.status = AllFacilitiesStatus.loading, this.facilities = const []});

  AllFacilitiesState copyWith(
      {AllFacilitiesStatus? status, List<SportFacility>? facilities}) {
    return AllFacilitiesState(
        status: status ?? this.status,
        facilities: facilities ?? this.facilities);
  }

  @override
  List<Object> get props => [status, facilities];
}
