part of 'attendance_bloc.dart';

class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class InitializeAttendance extends AttendanceEvent {
}

class AttendanceRegistered extends AttendanceEvent{}

class GetUserAttendance extends AttendanceEvent {
  final String token;
  final int id;

  GetUserAttendance(this.token, this.id);

  @override
  List<Object> get props => [token, id];
}

class AttendanceCreate extends AttendanceEvent {
  final Attendance attendance;
  final String token;
  final int id;

  AttendanceCreate(this.token, this.id, this.attendance);

  @override
  List<Object> get props => [token, id, attendance];
}

class AttendanceUpdate extends AttendanceEvent {
  final String token;
  final int id;
  final bool present;

  AttendanceUpdate(this.token, this.id, this.present);

  @override
  List<Object> get props => [token, id, present];
}

class AttendanceDelete extends AttendanceEvent {
  final String token;
  final int id;

  AttendanceDelete(this.token, this.id);

  @override
  List<Object> get props => [token, id];
}

class GetAttendanceHistoryOfUser extends AttendanceEvent {
  final String token;
  final int id;

  GetAttendanceHistoryOfUser(this.token, this.id);

  @override
  List<Object> get props => [token, id];
}

class GetTodayAttendanceOfAllUsers extends AttendanceEvent {
  final String token;
  final String date;

  GetTodayAttendanceOfAllUsers(this.token, this.date);

  @override
  List<Object> get props => [token, date];
}

class DeleteAttendanceHistoryOfUser extends AttendanceEvent {
  final String token;
  final int id;

  DeleteAttendanceHistoryOfUser(this.token, this.id);

  @override
  List<Object> get props => [token, id];
}
