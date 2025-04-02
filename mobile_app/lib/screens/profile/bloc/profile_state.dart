part of 'profile_bloc.dart';

enum ProfileLoadingStatus { loaded, loading, error, saving, saved, savingError }

enum AvatarLoadingStatus { idle, saving, saved, savingError }

class ProfileState extends Equatable {
  final ProfileLoadingStatus status;
  final AvatarLoadingStatus avatarStatus;
  final UserDto? user;
  final String? avatarUrl;
  const ProfileState(
      {this.status = ProfileLoadingStatus.loading,
      this.avatarStatus = AvatarLoadingStatus.idle,
      this.user,
      this.avatarUrl});

  ProfileState copyWith(
      {ProfileLoadingStatus? status,
      AvatarLoadingStatus? avatarStatus,
      UserDto? user,
      String? avatarUrl}) {
    return ProfileState(
        status: status ?? this.status,
        avatarStatus: avatarStatus ?? this.avatarStatus,
        user: user ?? this.user,
        avatarUrl: avatarUrl ?? this.avatarUrl);
  }

  @override
  List<Object?> get props => [status, avatarStatus, user, avatarUrl];
}
