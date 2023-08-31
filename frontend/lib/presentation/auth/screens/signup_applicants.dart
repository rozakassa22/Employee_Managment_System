import 'package:employee_management_system/presentation/presentation_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupApplicants extends StatelessWidget {
  SignupApplicants({Key? key}) : super(key: key);

  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Applicants List"),
        ),
        body: ListView(
          children: [
            BlocBuilder<SignupBloc, SignupState>(
              builder: (_, state) {
                if (state is SignUpFailure) {
                  return const Text('Could not load applicants');
                }
                if (state is ApplicantsLoaded) {
                  final users = state.users;
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return customTile(context, users.elementAt(index).id!,
                          users.elementAt(index));
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.more_rounded),
          onPressed: () {
            BlocProvider.of<SignupBloc>(context).add(ApplicantsLoading());
          },
        ),
      ),
    );
  }
}

Widget customTile(BuildContext context, int id, User user) {
  return Card(
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
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SignupBloc>(context)
                      .add(ApprovedUser(id, user));
                },
                child: Text("Approve")),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SignupBloc>(context)
                      .add(RejectedUser(id, user));
                },
                child: Text("Reject")),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
