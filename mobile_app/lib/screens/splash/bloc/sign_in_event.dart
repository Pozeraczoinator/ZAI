part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class LogInEvent extends SignInEvent {
  final String email;
  final String password;
  LogInEvent(this.email, this.password);
}

class RegisterEvent extends SignInEvent {
  final String email;
  final String password;
  final String name;
  final String surname;
  RegisterEvent(this.name, this.surname, this.email, this.password);
}

class OnStartEvent extends SignInEvent {}

class AuthenticationStatusChangedEvent extends SignInEvent {
  final AuthenticationStatus status;
  AuthenticationStatusChangedEvent(this.status);
}
