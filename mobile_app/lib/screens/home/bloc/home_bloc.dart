import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/models/sport_facility_news.dart';
import 'package:sport_plus/models/sport_facility.dart';
import 'package:sport_plus/repository/auth_repository.dart';
import 'package:sport_plus/repository/news_repository.dart';
import 'package:sport_plus/repository/sport_facility_repository.dart';
import 'package:sport_plus/screens/home/models/news.dart';
import 'package:sport_plus/services/location_service.dart';
import 'package:sport_plus/services/storage_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StorageService storageService;
  final LocationService locationService;
  final SportFacilityRepository sportFacilityRepository;
  final NewsRepository newsRepository;
  final AuthRepository authRepository;
  HomeBloc(
      {required this.storageService,
      required this.locationService,
      required this.sportFacilityRepository,
      required this.newsRepository,
      required this.authRepository})
      : super(const HomeState()) {
    on<HomeLoadingEvent>(_loadData);
    on<SignOutEvent>(_signOut);
  }
  Future<void> _loadData(
      HomeLoadingEvent event, Emitter<HomeState> emitter) async {
    emitter(state.copyWith(status: HomeLoadingStatus.loading));
    List<SportFacility>? allFacilities =
        await sportFacilityRepository.getAllFacilities();
    List<SportFacility>? userFacilities =
        await sportFacilityRepository.getUserFacilities();
    List<SportFacilityNews>? news = await newsRepository.getAllNews();
    if (allFacilities == null || userFacilities == null || news == null) {
      emitter(state.copyWith(status: HomeLoadingStatus.error));
      return;
    }
    List<News> castedNews = [];
    for (var element in news) {
      castedNews.add(News.fromResponse(element, allFacilities));
    }
    List<SportFacility> props = allFacilities;

    props.removeWhere((facility) => userFacilities
        .any((userFacility) => userFacility.name == facility.name));
    var propositions = await locationService.getTheClosestFacilities(props);

    emitter(state.copyWith(
        status: HomeLoadingStatus.loaded,
        propositions: propositions,
        userFacility: userFacilities,
        news: castedNews));
  }

  Future<void> _signOut(SignOutEvent event, Emitter<HomeState> emitter) async {
    await authRepository.logOut();
  }
}
