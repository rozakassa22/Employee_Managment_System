import 'package:employee_management_system/presentation/presentation_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../application_index.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository attendanceRepository;
  AttendanceBloc({required this.attendanceRepository})
      : super(AttendanceInitial()) {
    on<InitializeAttendance>((event, emit) {
      emit(AttendanceInitialized());
    });

    on<GetUserAttendance>((event, emit) async {
      try {
        final res = await attendanceRepository.getTodaysAttendanceOfUser(
            event.token, event.id);
        emit(TodayUserAttendance(res));
      } catch (e) {
        emit(AttendanceFailure(e));
      }
    });

    on<AttendanceCreate>((event, emit) async {
      try {
        await attendanceRepository.createAttendance(
            event.token, event.id, event.attendance);
        emit(AttendanceCreated(event.attendance));
      } catch (e) {
        emit(AttendanceFailure(e));
      }
    });

    on<AttendanceUpdate>((event, emit) async {
      try {
        final res = await attendanceRepository.updateAttendance(
            event.token, event.id, event.present);
        emit(AttendanceUpdated(res));
      } catch (e) {
        emit(AttendanceFailure(e));
      }
    });

    on<AttendanceDelete>((event, emit) async {
      try {
        await attendanceRepository.deleteAttendance(event.token, event.id);
        emit(AttendanceDeleted());
      } catch (e) {
        emit(AttendanceFailure(e));
      }
    });

    on<GetAttendanceHistoryOfUser>((event, emit) async {
      try {
        final res = await attendanceRepository.getAttendanceHistoryOfUser(
            event.token, event.id);
        emit(AttendanceHistoryOfUserLoaded(res));
      } catch (e) {
        emit(AttendanceFailure(e));
      }
    });

    on<GetTodayAttendanceOfAllUsers>((event, emit) async {
      try {
        final res = await attendanceRepository.getTodayAttendanceOfAllUsers(
            event.token, event.date);
        emit(LoadTodaysAttendancesOfAllUsers(res));
      } catch (e) {
        emit(AttendanceFailure(e));
      }
    });

    on<DeleteAttendanceHistoryOfUser>((event, emit) async {
      try {
        await attendanceRepository.deleteAttendanceHistoryOfUser(
            event.token, event.id);
        emit(AttendanceHistoryOfUserDeleted());
      } catch (e) {
        emit(AttendanceFailure(e));
      }
    });

    on<AttendanceRegistered>((event, emit) {
      emit(AttendanceChecked());
    });
  }
}
