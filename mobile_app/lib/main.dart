import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/navigation_routes.dart';
import 'package:sport_plus/repository/auth_repository.dart';
import 'package:sport_plus/screens/home/home_screen.dart';
import 'package:sport_plus/screens/splash/bloc/sign_in_bloc.dart';
import 'package:sport_plus/screens/splash/splash_screen.dart';
import 'package:sport_plus/services/http/cert_overrides.dart';
import 'package:sport_plus/services/locator.dart';

void main() async {
  setUp();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pl_PL');
  HttpOverrides.global = CertOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator.get<SignInBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConsts.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
          useMaterial3: true,
        ),
        navigatorKey: _navigatorKey,
        builder: (ctx, child) {
          return BlocListener<SignInBloc, SignInState>(
            listenWhen: (previous, current) {
              return previous.authenticationStatus !=
                  current.authenticationStatus;
            },
            listener: (ctx2, state) {
              switch (state.authenticationStatus) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushNamedAndRemoveUntil(
                    HomeScreen.route,
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unauthenticated:
                case AuthenticationStatus.unknown:
                  _navigator.pushNamedAndRemoveUntil(
                    SplashScreen.route,
                    (route) => false,
                  );
                  break;
              }
            },
            child: child,
          );
        },
        routes: routes,
      ),
    );
  }
}
