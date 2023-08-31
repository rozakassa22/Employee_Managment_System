import 'package:employee_management_system/presentation/presentation_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/core_index.dart';

import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  final formKey = GlobalKey<FormState>();
  final emailControle = TextEditingController();
  final passwordControle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
        ),
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            padding: const EdgeInsets.all(40.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.amber,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.red,
                ),
                const SizedBox(
                  height: 30,
                ),
                //todo: put all the appropriate infomrmation of the user inside here
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (_, state) {
                    if (state is ProfileFailure) {
                      return const Text('Could not load applicants');
                    }
                    if (state is ProfileRecived) {
                      final user = state.user;
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomEmailField(
                                controller: emailControle,
                                labelText: "Email",
                                hintText: "${user.email}",
                                validator: (String? email) {
                                  if (email != null) {
                                    final validEmail =
                                        RegExp("[A-Za-z0-9]@[A-Za-z].[A-Za-z]");
                                    final correct = validEmail.hasMatch(email);
                                    return correct
                                        ? null
                                        : "Enter a valid email";
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 20),
                            CustomEmailField(
                              controller: passwordControle,
                              labelText: "Password",
                              hintText: "New password",
                              validator: (String? password) {
                                if (password != null || password!.isNotEmpty) {
                                  final validPassword = password.length >= 6;
                                  return validPassword
                                      ? null
                                      : "Password too short";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            BlocListener<ProfileBloc, ProfileState>(
                              listener: (_, state) {
                                if (state is ProfileFailure) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('${state.message}'),
                                  ));
                                  GoRouter.of(context).push('/edit-profile');
                                }
                                if (state is ProfileUpdateSuccessfull) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('profile updated successfully'),
                                  ));
                                  GoRouter.of(context).pop();
                                  BlocProvider.of<ProfileBloc>(context).add(
                                      GetProfile(loggedInUser!.token.toString(),
                                          loggedInUser!.id!));
                                }
                              },
                              child: InkWell(
                                child: SignUpContainer(st: "Update"),
                                onTap: () {
                                  final formValid =
                                      formKey.currentState!.validate();
                                  if (!formValid) return;
                                  (context).read<ProfileBloc>().add(
                                        ProfileUpdate(
                                            User(
                                              id: loggedInUser!.id,
                                              email: emailControle.text,
                                              password: passwordControle.text,
                                              role: loggedInUser!.role,
                                            ),
                                            loggedInUser!.token.toString()),
                                      );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





// class EditProfile extends StatelessWidget {
//   EditProfile({Key? key}) : super(key: key);
//   AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 1,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.green,
//           ),
//           onPressed: () {},
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: 16, top: 25, right: 16),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               Text(
//                 "Edit Profile",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               width: 4,
//                               color: Theme.of(context).scaffoldBackgroundColor),
//                           boxShadow: [
//                             BoxShadow(
//                                 spreadRadius: 2,
//                                 blurRadius: 10,
//                                 color: Colors.black.withOpacity(0.1),
//                                 offset: Offset(0, 10))
//                           ],
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(
//                                 "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
//                               ))),
//                     ),
//                     Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               width: 4,
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                             ),
//                             color: Colors.green,
//                           ),
//                           child: Icon(
//                             Icons.edit,
//                             color: Colors.white,
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 35,
//               ),
//               buildTextField("Full Name", "Dor Alex", false),
//               buildTextField("E-mail", "alexd@gmail.com", false),
//               buildTextField("Password", "********", true),
//               buildTextField("Location", "TLV, Israel", false),
//               SizedBox(
//                 height: 35,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutlinedButton(
//                     style: ButtonStyle(
//                        padding: EdgeInsetsGeometry(),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     ),
                   
//                     onPressed: () {},
//                     child: Text("CANCEL",
//                         style: TextStyle(
//                             fontSize: 14,
//                             letterSpacing: 2.2,
//                             color: Colors.black)),
//                   ),
//                   RaisedButton(
//                     onPressed: () {},
//                     color: Colors.green,
//                     padding: EdgeInsets.symmetric(horizontal: 50),
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Text(
//                       "SAVE",
//                       style: TextStyle(
//                           fontSize: 14,
//                           letterSpacing: 2.2,
//                           color: Colors.white),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//   Widget buildTextField(
//       String labelText, String placeholder, bool isPasswordTextField) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 35.0),
//       child: TextField(
//         obscureText: isPasswordTextField ? showPassword : false,
//         decoration: InputDecoration(
//             suffixIcon: isPasswordTextField
//                 ? IconButton(
//                     onPressed: () {
//                       setState(() {
//                         showPassword = !showPassword;
//                       });
//                     },
//                     icon: Icon(
//                       Icons.remove_red_eye,
//                       color: Colors.grey,
//                     ),
//                   )
//                 : null,
//             contentPadding: EdgeInsets.only(bottom: 3),
//             labelText: labelText,
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             )),
//       ),
//     );
//   }


