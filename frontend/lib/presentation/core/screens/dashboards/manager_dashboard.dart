import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core_index.dart';

class ManagerDashboard extends StatelessWidget {
  ManagerDashboard({Key? key}) : super(key: key);

  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Manager Dashboard"),
          actions: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (_, state) {
              if (state is AuthenticationAuthenticated) {
                return Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 20,
                      child: Text(
                        state.user.email!.substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          UserLogOut(),
                        );
                        GoRouter.of(context).push('/login');
                      },
                    ),
                  ],
                );
              } else {
                return Text("not logged in");
              }
            }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 7.0,
            mainAxisSpacing: 8.0,
            children: List.generate(
              manager_choices.length,
              (index) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          GoRouter.of(context).push('/attendance-check');
                          BlocProvider.of<ProfileBloc>(context).add(
                              LoadProfiles(loggedInUser!.token.toString(),
                                  loggedInUser!.id!));
                          break;
                        case 1:
                          GoRouter.of(context).push('/notifications');
                          BlocProvider.of<MessageBloc>(context).add(
                              GetRecivedMessages(
                                  token: loggedInUser!.token.toString(),
                                  userId: loggedInUser!.id!));
                          break;
                        case 2:
                          GoRouter.of(context).push('/create-announcement');
                          break;
                        case 3:
                          GoRouter.of(context).push('/sent-notifications');
                          BlocProvider.of<MessageBloc>(context).add(
                              GetSentMessage(
                                  token: loggedInUser!.token.toString(),
                                  userId: loggedInUser!.id!));
                          break;
                        case 4:
                          GoRouter.of(context).push('/employees-list');
                          BlocProvider.of<ProfileBloc>(context).add(
                              LoadProfiles(loggedInUser!.token.toString(),
                                  loggedInUser!.id!));
                          break;
                        case 5:
                          GoRouter.of(context).push('/profile');
                          BlocProvider.of<ProfileBloc>(context).add(GetProfile(
                              loggedInUser!.token.toString(),
                              loggedInUser!.id!));
                          break;
                      }
                    },
                    child: SelectCard(
                      choice: manager_choices[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

const List<Choice> manager_choices = <Choice>[
  Choice(title: 'Attendance', icon: Icons.calendar_today_rounded),
  Choice(title: 'Notification', icon: Icons.notification_important_rounded),
  Choice(title: 'New Announcement', icon: Icons.notification_add),
  Choice(title: 'Sent-Messages', icon: Icons.list_alt_rounded),
  Choice(title: 'Employees', icon: Icons.list_rounded),
  Choice(title: 'Profile', icon: Icons.contact_page_rounded),
];
