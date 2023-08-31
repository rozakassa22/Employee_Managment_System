part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {

  AttendanceInitial();

    @override
  List<Object> get props => [];
}

class AttendanceInitialized extends AttendanceState {}

class TodayUserAttendance extends AttendanceState {
  final Attendance attendance;


  TodayUserAttendance(this.attendance);

  @override
  List<Object> get props => [attendance];

}

class AttendanceCreated extends AttendanceState {
  final Attendance attendance;

  AttendanceCreated(this.attendance);

  @override
  List<Object> get props => [attendance];
}

class AttendanceUpdated extends AttendanceState {
  final Attendance attendance;

  AttendanceUpdated(this.attendance);

  @override
  List<Object> get props => [attendance];
}

class AttendanceDeleted extends AttendanceState {}

class AttendanceHistoryOfUserLoaded extends AttendanceState {
  final List<Attendance> attendanceHistory;

  AttendanceHistoryOfUserLoaded(this.attendanceHistory);

  @override
  List<Object> get props => [attendanceHistory];
}

class LoadTodaysAttendancesOfAllUsers extends AttendanceState {
  final List<AttendanceList> attendanceList;

  LoadTodaysAttendancesOfAllUsers(this.attendanceList);

  @override
  List<Object> get props => [attendanceList];
}

class TodayAttendance extends AttendanceState {
  final Attendance attendance;

  TodayAttendance(this.attendance);

  @override
  List<Object> get props => [attendance];
}

class AttendanceHistoryOfUserDeleted extends AttendanceState {
  AttendanceHistoryOfUserDeleted();

  @override
  List<Object> get props => [];
}

class AttendanceChecked extends AttendanceState {
  AttendanceChecked();

  @override
  List<Object> get props => [];
}

class AttendanceFailure extends AttendanceState {
  final Object message;

  AttendanceFailure(this.message);

  @override
  List<Object> get props => [message];
}
