import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../application_index.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

//todo: this bloc is the main bloc which is accessible in the whole app
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    //applied on the welcome screen
    on<AppLoaded>((event, emit) async {
      emit(AuthenticationLoading());
      // print('Loading ');
      final user = await userRepository.getCurrentUser();
      // print(user?.email);
      if (user != null) {
        emit(AuthenticationAuthenticated(user: user));
      }
      emit(AuthenticationNotAuthenticated());
    });

    on<UserLogIn>((event, emit) async {
      try {
        final user = await userRepository.login(event.email, event.password);
        emit(AuthenticationAuthenticated(user: user));
      } catch (error) {
        emit(AuthenticationFailure(message: error));
      }
    });

    on<UserLogOut>((event, emit) async {
      bool result = await userRepository.logout();
      if (result) {
        emit(AuthenticationNotAuthenticated());
      } else {
        final user = await userRepository.getCurrentUser();
        emit(AuthenticationAuthenticated(user: user!));
      }
    });
  }
}
