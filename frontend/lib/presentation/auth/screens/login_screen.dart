import 'package:employee_management_system/presentation/routes/constants.dart';
import 'package:go_router/go_router.dart';

import '../auth_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailControle = TextEditingController();
  final passwordControle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    customText(
                        txt: "Login Now",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    customText(
                        txt: "Please login to continue using our app.",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        )),
                    const SizedBox(
                      height: 120,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomEmailField(
                              controller: emailControle,
                              labelText: "Email",
                              hintText: "Email",
                              validator: (String? email) {
                                if (email == null || email.isEmpty) {
                                  return "Email must not be empty";
                                }
                                final validEmail =
                                    RegExp("[A-Za-z0-9]@[A-Za-z].[A-Za-z]");
                                final correct = validEmail.hasMatch(email);
                                return correct ? null : "Enter a valid email";
                              }),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: passwordControle,
                            labelText: "Password",
                            hintText: "Password",
                            validator: (String? password) {
                              if (password == null || password.isEmpty) {
                                return "Password must not be empty";
                              }

                              final validPassword = password.length >= 6;
                              return validPassword
                                  ? null
                                  : "Password too short";
                            },
                          ),
                          const SizedBox(height: 20),
                          BlocListener<AuthenticationBloc, AuthenticationState>(
                            listener: (_, state) {
                              if (state is AuthenticationFailure) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('${state.message}'),
                                ));
                                GoRouter.of(context).go('/login');
                              }
                              if (state is AuthenticationAuthenticated) {
                                if (state.user.role.toString() == "owner") {
                                  GoRouter.of(context).go('/owner-dashboard');
                                } else if (state.user.role.toString() ==
                                    "employee") {
                                  GoRouter.of(context)
                                      .go('/employee-dashboard');
                                } else {
                                  GoRouter.of(context).go('/manager-dashboard');
                                }
                              }
                              if (state is AuthenticationLoading) {
                                GoRouter.of(context).go('/login');
                              }
                            },
                            child: InkWell(
                              child: SignUpContainer(st: "LogIn"),
                              onTap: () {
                                final formValid =
                                    formKey.currentState!.validate();
                                if (!formValid) return;
                                (context).read<AuthenticationBloc>().add(
                                      UserLogIn(
                                        emailControle.text,
                                        passwordControle.text,
                                      ),
                                    );
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      child: RichText(
                        text: RichTextSpan(
                            one: "Don’t have an account ? ", two: "Sign Up"),
                      ),
                      onTap: () {
                        GoRouter.of(context).go('/create-account');
                        BlocProvider.of<SignupBloc>(context)
                            .add(SignupInitial());
                      },
                    ),
                    //Text("data"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
