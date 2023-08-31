import 'package:employee_management_system/presentation/presentation_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application_index.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<LoadProfiles>((event, emit) async {
      try {
        final users =
            await profileRepository.getAllUsersProfile(event.token, event.id);
        emit(ProfileLoaded(users));
      } catch (error) {
        emit(ProfileFailure(error));
      }
    });

    on<GetProfile>((event, emit) async {
      try {
        final user = await profileRepository.getUserProfile(event.token, event.id);
        emit(ProfileRecived(user));
      } catch (error) {
        emit(ProfileFailure(error));
      }
    });
    on<DeleteProfile>((event, emit) async {
      try {
        bool res =
            await profileRepository.deleteUserProfile(event.token, event.id);
        if (res) {
          final users =
              await profileRepository.getAllUsersProfile(event.token, event.id);
          emit(ProfileLoaded(users));
        } else {
          emit(ProfileFailure("Failed to delete user"));
        }
      } catch (err) {
        emit(ProfileFailure(err));
      }
    });

    on<RevokeUserRole>((event, emit) async {
      try {
        bool res = await profileRepository.revokeUserRole(
            event.token, event.id, event.role);
        print(res);
        if (res) {
          final users =
              await profileRepository.getAllUsersProfile(event.token, event.id);
          emit(ProfileLoaded(users));
        } else {
          emit(ProfileFailure("Failed to revoke user"));
        }
      } catch (err) {
        emit(ProfileFailure(err));
      }
    });

    on<ProfileUpdate>(((event, emit) async {
      try {
        final user = await profileRepository.updateUserProfile(
            event.user, event.token);
        emit(ProfileUpdateSuccessfull());
      } catch (err) {
        emit(ProfileFailure(err));
      }
    }));
  }
}
