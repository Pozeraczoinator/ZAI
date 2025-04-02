import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/models/user/user_dto.dart';
import 'package:sport_plus/screens/profile/bloc/profile_bloc.dart';
import 'package:sport_plus/screens/profile/edit_profile/widgets/edit_avatar.dart';
import 'package:sport_plus/utils/form_validators.dart';
import 'package:sport_plus/widgets/app_scaffold.dart';
import 'package:sport_plus/widgets/generic_button.dart';

class EditProfileLoadingView extends StatefulWidget {
  final UserDto user;
  const EditProfileLoadingView({super.key, required this.user});

  @override
  State<EditProfileLoadingView> createState() => _EditProfileLoadingViewState();
}

class _EditProfileLoadingViewState extends State<EditProfileLoadingView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  @override
  void didChangeDependencies() {
    _nameController.text = widget.user.name ?? "";
    _surnameController.text = widget.user.surname ?? "";
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EditAvatar(),
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
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: GenericButton(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<ProfileBloc>().add(UpdateProfileEvent(
                            name: _nameController.text,
                            surname: _surnameController.text));
                      }
                    },
                    title: AppStrings.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
