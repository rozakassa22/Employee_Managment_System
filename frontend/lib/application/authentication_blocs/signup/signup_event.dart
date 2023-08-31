part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupEvent {}

class SignUp extends SignupEvent {
  final User user;

  const SignUp({required this.user});

  @override
  List<Object> get props => [user];
  @override
  String toString() => 'User Created {course Id: ${user.id}}';
}

class ApplicantsLoading extends SignupEvent {}

class ApprovedUser extends SignupEvent {
  final int id;
  final User user;

  ApprovedUser(this.id, this.user);

  @override
  List<Object> get props => [id, user];
}

class RejectedUser extends SignupEvent {
  final int id;
  final User user;

  RejectedUser(this.id, this.user);

  @override
  List<Object> get props => [id, user];
}
