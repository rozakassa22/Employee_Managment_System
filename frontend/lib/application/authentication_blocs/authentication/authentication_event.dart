part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}
// Fired just after the app is launched
// class AppLoaded extends AuthenticationEvent {}

class UserLogIn extends AuthenticationEvent {
  final String email;
  final String password;
  UserLogIn(this.email, this.password);

  @override
  List<Object> get props => [];
}


class UserLogOut extends AuthenticationEvent {}








class UserLoggingIn extends AuthenticationEvent {
  final User user;

  UserLoggingIn({required this.user});

  @override
  List<Object> get props => [user];
}

class UserPersist extends AuthenticationEvent {
  final AuthenticatedUser user;

  UserPersist({required this.user});

  @override
  List<Object> get props => [user];
}

// Fired when a user has successfully logged in


// Fired when the user has logged out
class UserLoggedOut extends AuthenticationEvent {
  UserLoggedOut();

  @override
  List<Object> get props => [];
}
