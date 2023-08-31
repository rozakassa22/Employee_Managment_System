part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final AuthenticatedUser user;

  AuthenticationAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}



class AuthenticationNotAuthenticated extends AuthenticationState {}



class AuthenticationFailure extends AuthenticationState {
  final Object message;

  AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];
}

// //Signup 

// class SignupSuccessfull extends AuthenticationState {
//   @override
//   List<Object> get props => [];
// }

// class Approved extends AuthenticationState {}
// class Rejected extends AuthenticationState {}

// // these two events fire while loading applicants
// class ApplicantsLoaded extends AuthenticationState {
//   final Iterable<User> users;

//   const ApplicantsLoaded([this.users = const []]);

//   @override
//   List<Object> get props => [users];
// }

// class SignUpFailure extends AuthenticationState {
//   final Object error;

//   SignUpFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }