import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/screens/calendar/bloc/calendar_bloc.dart';
import 'package:sport_plus/screens/calendar/calendar_screen.dart';
import 'package:sport_plus/screens/facilities/all_facilities_screen.dart';
import 'package:sport_plus/screens/facilities/bloc/all_facilities_bloc.dart';
import 'package:sport_plus/screens/facility_details/bloc/facility_details_bloc.dart';
import 'package:sport_plus/screens/facility_details/facility_details_screen.dart';
import 'package:sport_plus/screens/home/bloc/home_bloc.dart';
import 'package:sport_plus/screens/home/home_screen.dart';
import 'package:sport_plus/screens/map/bloc/map_bloc.dart';
import 'package:sport_plus/screens/map/map_screen.dart';
import 'package:sport_plus/screens/profile/bloc/profile_bloc.dart';
import 'package:sport_plus/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:sport_plus/screens/profile/profile/profile_screen.dart';
import 'package:sport_plus/screens/splash/bloc/sign_in_bloc.dart';
import 'package:sport_plus/screens/splash/sign_in_screen.dart';
import 'package:sport_plus/screens/splash/sign_up_screen.dart';
import 'package:sport_plus/screens/splash/splash_screen.dart';
import 'package:sport_plus/screens/trainings/bloc/trainings_bloc.dart';
import 'package:sport_plus/screens/trainings/trainings_screen.dart';
import 'package:sport_plus/services/locator.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.route: (context) => BlocProvider.value(
        value: locator.get<HomeBloc>()..add(HomeLoadingEvent()),
        child: const HomeScreen(),
      ),
  FacilityDetailsScreen.route: (context) => BlocProvider.value(
        value: locator.get<FacilityDetailsBloc>(),
        child: const FacilityDetailsScreen(),
      ),
  TrainingsScreen.route: (context) => BlocProvider.value(
        value: locator.get<TrainingsBloc>(),
        child: const TrainingsScreen(),
      ),
  ProfileScreen.route: (context) => BlocProvider.value(
        value: locator.get<ProfileBloc>()..add(InitDateEvent()),
        child: const ProfileScreen(),
      ),
  EditProfileScreen.route: (context) => BlocProvider.value(
        value: locator.get<ProfileBloc>(),
        child: const EditProfileScreen(),
      ),
  SplashScreen.route: (context) => BlocProvider.value(
        value: locator.get<SignInBloc>(),
        child: const SplashScreen(),
      ),
  SignInScreen.route: (context) => BlocProvider.value(
        value: locator.get<SignInBloc>(),
        child: const SignInScreen(),
      ),
  SignUpScreen.route: (context) => BlocProvider.value(
        value: locator.get<SignInBloc>(),
        child: const SignUpScreen(),
      ),
  MapScreen.route: (context) => BlocProvider.value(
        value: locator.get<MapBloc>()..add(InitDataEvent()),
        child: const MapScreen(),
      ),
  CalendarScreen.route: (context) => BlocProvider.value(
        value: locator.get<CalendarBloc>()..add(InitTrainingDataEvent()),
        child: const CalendarScreen(),
      ),
  AllFacilitiesScreen.route: (context) => BlocProvider.value(
        value: locator.get<AllFacilitiesBloc>()..add(InitFacilityDataEvent()),
        child: const AllFacilitiesScreen(),
      ),
};
