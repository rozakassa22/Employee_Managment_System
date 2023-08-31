part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Iterable<User> users;

  const ProfileLoaded([this.users = const []]);

  @override
  List<Object> get props => [users];
}

class ProfileRecived extends ProfileState {
  final User user;

  const ProfileRecived(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileDeleted extends ProfileState {}

class UserRevoked extends ProfileState {}

class ProfileUpdateSuccessfull extends ProfileState {}

class ProfileFailure extends ProfileState {
  final Object message;

  ProfileFailure(this.message);

  @override
  List<Object> get props => [message];
}
