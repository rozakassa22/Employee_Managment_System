// ignore_for_file: unnecessary_string_interpolations

import 'package:employee_management_system/presentation/presentation_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ViewProfile extends StatelessWidget {
  ViewProfile({Key? key}) : super(key: key);
  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            padding: const EdgeInsets.all(40.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              color: Colors.white,
              border: Border.all(
                color: Colors.amber,
                width: 1,
              ),
            ),
            child: BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
              if (state is ProfileFailure) {
                return const Text('Could not load applicants');
              }
              if (state is ProfileRecived) {
                final user = state.user;
                return Column(
                  children: [
                    //first
                    Row(
                      children: [
                        const SizedBox(
                          width: 270,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),

                            primary: Colors.blue[100], // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            BlocProvider.of<ProfileBloc>(context).add(
                                GetProfile(loggedInUser!.token.toString(),
                                    loggedInUser!.id!));
                            GoRouter.of(context).push('/edit-profile');
                          },
                          child: const Icon(Icons.edit),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 110,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          // const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(left: 110),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "${user.email}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    Text(
                                      "${user.role}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.email_sharp,
                                color: const Color.fromARGB(255, 1, 15, 27),
                              ),
                              const SizedBox(width: 100),
                              Text(
                                user.email,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.phone),
                              SizedBox(
                                width: 130,
                                height: 30,
                              ),
                              Text(
                                "+25199365760",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Street: ",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: 100),
                              Text(
                                "NewYork Street",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Department: ",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: 100),
                              Text(
                                "sales",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Text('Loading...');
              }
            }),
          ),
        ),
      ),
    );
  }
}
