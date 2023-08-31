import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application_index.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  SignupBloc({required this.userRepository}) : super(InitialSignup()) {
    on<SignupInitial>((event, emit) {
      emit(InitialSignup());
    });
    on<SignUp>((event, emit) async {
      try {
        await userRepository.createAccount(event.user);
        emit(SignupSuccessfull());
      } catch (error) {
        emit(SignUpFailure(error));
      }
    });

    // //todo: the employeer first need to be authenticated before using this route
    on<ApplicantsLoading>((event, emit) async {
      try {
        final users = await userRepository.getApplicants();
        emit(ApplicantsLoaded(users));
      } catch (e) {
        emit(SignUpFailure(e));
      }
    });
    on<ApprovedUser>((event, emit) async {
      try {
        await userRepository.approveApplicant(event.id, event.user);
        final users = await userRepository.getApplicants();
        emit(ApplicantsLoaded(users));
      } catch (error) {
        emit(SignUpFailure(error));
      }
    });

    on<RejectedUser>((event, emit) async {
      try {
        await userRepository.rejectApplicant(event.id, event.user);
        final users = await userRepository.getApplicants();
        emit(ApplicantsLoaded(users));
      } catch (error) {
        emit(SignUpFailure(error));
      }
    });
  }
}
