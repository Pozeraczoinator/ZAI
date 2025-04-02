part of 'home_bloc.dart';

enum HomeLoadingStatus { loading, loaded, error }

class HomeState extends Equatable {
  final HomeLoadingStatus status;
  final List<SportFacility> userFacility;
  final List<SportFacility> propositions;
  final List<News> news;
  const HomeState({
    this.status = HomeLoadingStatus.error,
    this.propositions = const [],
    this.userFacility = const [],
    this.news = const [],
  });

  HomeState copyWith(
      {HomeLoadingStatus? status,
      List<SportFacility>? userFacility,
      List<SportFacility>? propositions,
      List<News>? news}) {
    return HomeState(
        status: status ?? this.status,
        userFacility: userFacility ?? this.userFacility,
        propositions: propositions ?? this.propositions,
        news: news ?? this.news);
  }

  @override
  List<Object> get props => [status, userFacility, propositions, news];
}
