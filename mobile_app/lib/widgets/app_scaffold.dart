import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/calendar/calendar_screen.dart';
import 'package:sport_plus/screens/facilities/all_facilities_screen.dart';
import 'package:sport_plus/screens/home/bloc/home_bloc.dart';
import 'package:sport_plus/screens/map/map_screen.dart';
import 'package:sport_plus/screens/profile/profile/profile_screen.dart';
import 'package:sport_plus/services/locator.dart';
import 'package:sport_plus/widgets/images/bar_logo.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final bool showDrawer;
  final bool setPadding;
  const AppScaffold(
      {super.key,
      required this.child,
      this.showDrawer = false,
      this.setPadding = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainColor,
        title: const Center(
          child: SizedBox(
            height: 50,
            child: BarLogo(),
          ),
        ),
      ),
      drawer: showDrawer
          ? Drawer(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, ProfileScreen.route);
                    },
                    leading: const Icon(Icons.person),
                    title: const Text(AppStrings.profile),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, CalendarScreen.route);
                    },
                    leading: const Icon(Icons.calendar_month),
                    title: const Text(AppStrings.yourTrainings),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, MapScreen.route);
                    },
                    leading: const Icon(Icons.map),
                    title: const Text(AppStrings.facilitiesMap),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AllFacilitiesScreen.route);
                    },
                    leading: const Icon(Icons.fitness_center),
                    title: const Text(AppStrings.allFacilities),
                  ),
                  BlocProvider.value(
                    value: locator.get<HomeBloc>(),
                    child: ListTile(
                      onTap: () {
                        context.read<HomeBloc>().add(SignOutEvent());
                      },
                      leading: const Icon(Icons.logout),
                      title: const Text(AppStrings.signOut),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: Padding(
        padding: EdgeInsets.all(setPadding ? 20 : 0),
        child: child,
      ),
    );
  }
}
