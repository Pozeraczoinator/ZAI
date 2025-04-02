import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_plus/models/sport_facility.dart';
import 'package:sport_plus/repository/sport_facility_repository.dart';

part 'all_facilities_event.dart';
part 'all_facilities_state.dart';

class AllFacilitiesBloc extends Bloc<AllFacilitiesEvent, AllFacilitiesState> {
  final SportFacilityRepository sportFacilityRepository;
  AllFacilitiesBloc({required this.sportFacilityRepository})
      : super(const AllFacilitiesState()) {
    on<InitFacilityDataEvent>(_initData);
  }
  Future<void> _initData(
      InitFacilityDataEvent event, Emitter<AllFacilitiesState> emitter) async {
    emitter(state.copyWith(status: AllFacilitiesStatus.loading));
    var facilities = await sportFacilityRepository.getAllFacilities();
    if (facilities == null) {
      emitter(state.copyWith(status: AllFacilitiesStatus.error));
    } else {
      emitter(state.copyWith(
          status: AllFacilitiesStatus.loaded, facilities: facilities));
    }
  }
}
