import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/splash/bloc/sign_in_bloc.dart';
import 'package:sport_plus/utils/form_validators.dart';
import 'package:sport_plus/widgets/app_scaffold.dart';
import 'package:sport_plus/widgets/generic_button.dart';
import 'package:sport_plus/widgets/loading_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String route = "/sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        switch (state.status) {
          case SignInLoadingStatus.error:
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text(AppStrings.error)));
            break;
          case SignInLoadingStatus.idle:
            break;
          case SignInLoadingStatus.loading:
            showDialog(
              context: context,
              builder: (context) => const LoadingDialog(),
            );
            break;
        }
      },
      child: AppScaffold(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      FormValidators.notEmpty(_nameController.text),
                  controller: _nameController,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.name,
                      style: AppTypography.defaultBoldTextStyle(
                          color: AppColors.mainColor),
                    ),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      FormValidators.notEmpty(_surnameController.text),
                  controller: _surnameController,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.surname,
                      style: AppTypography.defaultBoldTextStyle(
                          color: AppColors.mainColor),
                    ),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      FormValidators.emailValidator(_emailController.text),
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.email,
                      style: AppTypography.defaultBoldTextStyle(
                          color: AppColors.mainColor),
                    ),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: (value) => FormValidators.passwordValidator(
                      _passwordController.text),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.password,
                      style: AppTypography.defaultBoldTextStyle(
                          color: AppColors.mainColor),
                    ),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: (value) => FormValidators.confirmPasswordValidator(
                      _passwordController.text,
                      _passwordConfirmController.text),
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.confirmPassword,
                      style: AppTypography.defaultBoldTextStyle(
                          color: AppColors.mainColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GenericButton(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<SignInBloc>().add(RegisterEvent(
                            _nameController.text,
                            _surnameController.text,
                            _emailController.text,
                            _passwordController.text));
                      }
                    },
                    title: AppStrings.signUp,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
