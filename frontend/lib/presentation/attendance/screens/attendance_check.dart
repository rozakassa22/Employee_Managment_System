import 'package:employee_management_system/presentation/presentation_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AttendanceCheck extends StatelessWidget {
  AttendanceCheck({Key? key}) : super(key: key);

  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Attendance checker"),
        ),
        body: ListView(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (_, state) {
                if (state is ProfileFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text('Could not load users'),
                  ));
                }
                if (state is ProfileLoaded) {
                  final users = state.users;
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return userTile(context, users.elementAt(index).id!,
                          users.elementAt(index), loggedInUser!);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget userTile(
    BuildContext context, int id, User user, AuthenticatedUser loggedInUser) {
  return Card(
    child: BlocListener<AttendanceBloc, AttendanceState>(
      listener: ((context, state) {
        if (state is AttendanceFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Could not create attendance'),
          ));
        }
        if (state is AttendanceCreated) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('User is present'),
          ));
          BlocProvider.of<AttendanceBloc>(context).add(AttendanceRegistered());
        }
      }),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text("Email:"),
              const SizedBox(
                width: 10,
              ),
              Text(user.email)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<AttendanceBloc>(context).add(AttendanceCreate(
                    loggedInUser.token.toString(),
                    id,
                    Attendance(present: true, date: '')));
              },
              child: Text("Present")),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}
