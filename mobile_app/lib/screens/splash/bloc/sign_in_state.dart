part of 'sign_in_bloc.dart';

enum SignInLoadingStatus { idle, loading, error }

class SignInState extends Equatable {
  final SignInLoadingStatus status;
  final AuthenticationStatus authenticationStatus;
  const SignInState(
      {this.status = SignInLoadingStatus.idle,
      this.authenticationStatus = AuthenticationStatus.unknown});

  SignInState copyWith(
      {SignInLoadingStatus? status,
      AuthenticationStatus? authenticationStatus}) {
    return SignInState(
        status: status ?? this.status,
        authenticationStatus:
            authenticationStatus ?? this.authenticationStatus);
  }

  @override
  List<Object> get props => [status, authenticationStatus];
}
