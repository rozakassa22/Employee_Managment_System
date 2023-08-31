part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class InitialSignup extends SignupState {}

class SignupSuccessfull extends SignupState {
  @override
  List<Object> get props => [];
}

class Approved extends SignupState {}
class Rejected extends SignupState {}

// // these two events fire while loading applicants
class ApplicantsLoaded extends SignupState {
  final Iterable<User> users;

  const ApplicantsLoaded([this.users = const []]);

  @override
  List<Object> get props => [users];
}

class SignUpFailure extends SignupState {
  final Object error;

  SignUpFailure(this.error);

  @override
  List<Object> get props => [error];
}