// import 'package:go_router/go_router.dart';

import 'package:employee_management_system/presentation/routes/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentation_index.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    customText(
                        txt: "Welcome",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    customText(
                        txt:
                            "Please login or sign up to continue using our app.",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        )),
                    const SizedBox(
                      height: 90,
                    ),
                    Image.asset(
                      "assets/image/img1.png",
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    BlocListener<AuthenticationBloc, AuthenticationState>(
                      listener: ((context, state) {
                        if (state is AuthenticationAuthenticated) {
                          if (state.user.role.toString() == "owner") {
                            GoRouter.of(context).go('/owner-dashboard');
                          } else if (state.user.role.toString() == "employee") {
                            GoRouter.of(context).go('/employee-dashboard');
                          } else {
                            GoRouter.of(context).go('/manager-dashboard');
                          }
                        }
                        else {
                        GoRouter.of(context).go('/login');
                        }
                      }),
                      child: InkWell(
                        child: SignUpContainer(st: "Login"),
                        onTap: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(AppLoaded());
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      child: RichText(
                        text: RichTextSpan(
                            one: "Don’t have an account ? ", two: "Sign up"),
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
