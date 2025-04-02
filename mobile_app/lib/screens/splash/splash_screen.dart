import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/splash/bloc/sign_in_bloc.dart';
import 'package:sport_plus/screens/splash/sign_in_screen.dart';
import 'package:sport_plus/screens/splash/sign_up_screen.dart';
import 'package:sport_plus/widgets/generic_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String route = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool animationEnded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationEnded = true;
          context.read<SignInBloc>().add(OnStartEvent());
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/sport.json',
                  width: MediaQuery.of(context).size.width * 0.8,
                  repeat: false,
                  fit: BoxFit.fitHeight,
                  controller: _controller, onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 60, 50, 0),
            child: AnimatedOpacity(
              opacity: animationEnded ? 1.0 : 0,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  Text(
                    AppConsts.appName,
                    style: AppTypography.titleStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150, bottom: 10),
                    child: GenericButton(
                      onTap: () =>
                          Navigator.pushNamed(context, SignInScreen.route),
                      title: AppStrings.signIn,
                    ),
                  ),
                  GenericButton(
                    isPrimary: false,
                    onTap: () =>
                        Navigator.pushNamed(context, SignUpScreen.route),
                    title: AppStrings.signUp,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
