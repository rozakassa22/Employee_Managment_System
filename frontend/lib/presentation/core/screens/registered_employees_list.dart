import 'package:employee_management_system/presentation/presentation_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeesList extends StatelessWidget {
  EmployeesList({Key? key}) : super(key: key);

  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Owner Dashboard"),
        ),
        body: Center(
          child: Container(
            color: Colors.grey,
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (_, state) {
                    if (state is ProfileFailure) {
                      return const Text('Could not load applicants');
                    }
                    if (state is ProfileLoaded) {
                      final users = state.users;
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return customUserTile(
                              context,
                              users.elementAt(index).id!,
                              users.elementAt(index),
                              loggedInUser!);
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
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                    child: const Text("Load Users"),
                    onPressed: () {
                      BlocProvider.of<ProfileBloc>(context).add(LoadProfiles(
                          loggedInUser!.token.toString(), loggedInUser!.id!));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customUserTile(
    BuildContext context, int id, User newuser, AuthenticatedUser currentUser) {
  return Card(
    child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          radius: 40,
          child: Text(
            newuser.email.substring(0, 1),
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email:"),
            const SizedBox(width: 10),
            Text(newuser.email),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Role:"),
            const SizedBox(width: 10),
            Text(newuser.role!),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<ProfileBloc>(context).add(RevokeUserRole(
                currentUser.token.toString(),
                newuser.id!,
                newuser.role.toString()));
          },
          child:
              Text(newuser.role.toString() == "manager" ? "demote" : "promote"),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<ProfileBloc>(context)
                .add(DeleteProfile(currentUser.token.toString(), id));
          },
          child: Text("Delete"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
