part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfiles extends ProfileEvent {
  final String token;
  final int id;

  LoadProfiles(this.token, this.id);

  @override
  List<Object> get props => [token, id];
}

class DeleteProfile extends ProfileEvent {
  final String token;
  final int id;

  DeleteProfile(this.token, this.id);

  @override
  List<Object> get props => [token, id];
}

class RevokeUserRole extends ProfileEvent {
  final String token;
  final int id;
  final String role;

  RevokeUserRole(this.token, this.id, this.role);

  @override
  List<Object> get props => [token, id];
}

class GetProfile extends ProfileEvent {
  final String token;
  final int id;

  GetProfile(this.token, this.id);

  @override
  List<Object> get props => [token, id];
}

class ProfileUpdate extends ProfileEvent {
  final String token;
  final User user;

  ProfileUpdate(this.user, this.token);

  @override
  List<Object> get props => [user, token];
}
