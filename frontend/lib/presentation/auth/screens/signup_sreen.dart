import 'package:go_router/go_router.dart';

import '../auth_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    customText(
                        txt: "Sign Up",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    customText(
                        txt: "Please sign up to enter in a app.",
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
                              controller: emailController,
                              labelText: "Email",
                              hintText: "Email",
                              validator: (String? email) {
                                if (email == null || email.isEmpty) {
                                  return "Email must not be empty!";
                                }
                                final validEmail =
                                    RegExp("[A-Za-z]@[A-Za-z].[A-Za-z]");
                                final correct = validEmail.hasMatch(email);

                                return correct ? null : "Enter a valid email";
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: passwordController,
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
                            CustomEmailField(
                              controller: roleController,
                              labelText: "Role",
                              hintText: "role",
                              validator: (String? role) {
                                if (role == null || role.isEmpty) {
                                  return "role must not be empty!";
                                }

                                final correct =
                                    (role == "employee" || role == "manager");

                                return correct
                                    ? null
                                    : "role must be either employee or manager";
                              },
                            ),
                            const SizedBox(height: 20),
                            BlocListener<SignupBloc, SignupState>(
                              listener: (_, SignupState state) {
                                if (state is SignUpFailure) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('${state.error}'),
                                  ));
                                }
                                if (state is SignupSuccessfull) {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AppLoaded());
                                  GoRouter.of(context).go('/login');
                                }
                              },
                              child: InkWell(
                                child: SignUpContainer(st: "Sign up"),
                                onTap: () {
                                  final formValid =
                                      formKey.currentState!.validate();
                                  if (!formValid) return;
                                  (context).read<SignupBloc>().add(
                                        SignUp(
                                          user: User(
                                            id: null,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            role: roleController.text,
                                            approved: false,
                                          ),
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                        child: RichText(
                          text: RichTextSpan(
                              one: "Already have an account ? ", two: "Login"),
                        ),
                        onTap: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(AppLoaded());
                          GoRouter.of(context).go('/login');
                        }),
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
