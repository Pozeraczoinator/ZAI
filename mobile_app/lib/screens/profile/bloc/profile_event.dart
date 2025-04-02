part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class InitDateEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String surname;
  UpdateProfileEvent({required this.name, required this.surname});
}

class PickImageEvent extends ProfileEvent {
  final ImagePickerSource source;
  PickImageEvent(this.source);
}
