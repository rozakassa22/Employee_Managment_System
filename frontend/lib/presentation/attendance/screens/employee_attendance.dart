// import 'package:employee_management_system/presentation/presentation_index.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class EmployeeAttendance extends StatelessWidget {
//   EmployeeAttendance({Key? key}) : super(key: key);

//   static List<Attendance> attendanceHistory = [];

//   AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Attendance"),
//         ),
//         body: BlocBuilder<AttendanceBloc, AttendanceState>(builder: (_, state) {
//           if (state is AttendanceFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('Could get employee attendance'),
//             ));
//           }
//           if (state is AttendanceHistoryOfUserLoaded) {
//             return ListView(
//               scrollDirection: Axis.vertical,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: 16,
//                     right: 16,
//                     top: 16,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Attendance Status',
//                         style: Theme.of(context).textTheme.headline1,
//                       ),
//                       const SizedBox(height: 16),
//                       Container(
//                         height: 300,
//                         color: Colors.transparent,
//                         child: Center(
//                           child: Card(
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 16),
//                               child: Row(
//                                 children: [
//                                   const Text("Today's Attendance:"),
//                                   const SizedBox(width: 16),
//                                   Text(state.attendance.present ? "Present" : "Absent"),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 attendaceHistory(context, EmployeeAttendance.attendanceHistory,
//                     loggedInUser!),
//               ],
//             );
//           }
//           return Container();
//         }),
//       ),
//     );
//   }
// }

// Widget attendaceHistory(BuildContext context,
//     List<Attendance> attendanceHistory, AuthenticatedUser currentUser) {
//   return Padding(
//     padding: const EdgeInsets.only(
//       left: 16,
//       right: 16,
//       top: 0,
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Attendance History',
//           style: Theme.of(context).textTheme.headline1,
//         ),
//         const SizedBox(height: 16),
//         ListView.separated(
//           primary: false,
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           itemCount: attendanceHistory.length,
//           itemBuilder: (context, index) {
//             final attendance = attendanceHistory[index];
//             return attendanceTile(context, attendance);
//           },
//           separatorBuilder: (context, index) {
//             return const SizedBox(height: 16);
//           },
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         ElevatedButton(
//             onPressed: () {
//               BlocProvider.of<AttendanceBloc>(context).add(
//                   GetAttendanceHistoryOfUser(
//                       currentUser.token.toString(), currentUser.id!));
//               GoRouter.of(context).push('/attendance');
//             },
//             child: Text("load history")),
//       ],
//     ),
//   );
// }

// Widget attendanceTile(BuildContext context, Attendance attendance) {
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       CircleAvatar(
//         maxRadius: 10,
//         backgroundColor: attendance.present == true ? Colors.green : Colors.red,
//       ),
//       const SizedBox(width: 16),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(attendance.present == true ? "Present" : "Absent"),
//             Text(
//               attendance.date,
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

import 'package:employee_management_system/presentation/presentation_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeeAttendance extends StatefulWidget {
  EmployeeAttendance({Key? key}) : super(key: key);

  static List<Attendance> attendanceHistory = [];

  @override
  State<EmployeeAttendance> createState() => _EmployeeAttendanceState();
}

class _EmployeeAttendanceState extends State<EmployeeAttendance> {
  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;
  bool isPressed = false;

  void myCallback() {
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Attendance"),
        ),
        body: BlocBuilder<AttendanceBloc, AttendanceState>(builder: (_, state) {
          if (state is AttendanceFailure) {
            return const Text('Could get empoyee attendance');
          }
          if (state is AttendanceInitialized || state is AttendanceCreated) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                attendanceStatus(
                    context, loggedInUser!, isPressed, myCallback, state),
                SizedBox(height: 16),
                attendaceHistory(context, EmployeeAttendance.attendanceHistory,
                    loggedInUser!),
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}

Widget attendanceStatus(BuildContext context, AuthenticatedUser currentUser,
    bool isPressed, Function myCallback, AttendanceState state) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      top: 16,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attendance Status',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 16),
        Container(
          height: 300,
          color: Colors.transparent,
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("Today's Attendance:"),
                        SizedBox(width: 20),
                        if (state is! AttendanceCreated)
                          ElevatedButton(
                            onPressed: () {
                              String value = DateTime.now().toString();
                              String newvalue = value.substring(0, 10);
                              BlocProvider.of<AttendanceBloc>(context)
                                  .add(AttendanceCreate(
                                      currentUser.token.toString(),
                                      currentUser.id!,
                                      Attendance(
                                        id: null,
                                        date: newvalue,
                                        present: false,
                                      )));
                              isPressed == false ? myCallback : null;
                            },
                            child: Text("present"),
                          )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Presents: "),
                        SizedBox(width: 20),
                        Text("20"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text("Absents: "),
                        SizedBox(width: 10),
                        Text("10"),
                      ],
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget attendaceHistory(BuildContext context,
    List<Attendance> attendanceHistory, AuthenticatedUser currentUser) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      top: 0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attendance History',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: attendanceHistory.length,
          itemBuilder: (context, index) {
            final attendance = attendanceHistory[index];
            return attendanceTile(context, attendance);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<AttendanceBloc>(context).add(
                  GetAttendanceHistoryOfUser(
                      currentUser.token.toString(), currentUser.id!));
              GoRouter.of(context).push('/attendance');
            },
            child: Text("load history")),
      ],
    ),
  );
}

Widget attendanceTile(BuildContext context, Attendance attendance) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CircleAvatar(
        maxRadius: 10,
        backgroundColor: attendance.present == true ? Colors.green : Colors.red,
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(attendance.present == true ? "Present" : "Absent"),
            Text(
              attendance.date,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    ],
  );
}
