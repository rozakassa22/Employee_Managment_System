import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/presentation_index.dart';

void main() {
  final UserRepository userRepository = UserRepository(UserDataProvider());
  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(userRepository: UserRepository(UserDataProvider()));

  BlocOverrides.runZoned(
    () => runApp(
      MyApp(
        userRepository: userRepository,
        authenticationBloc: authenticationBloc,
      ),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(key: key);
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = MyRouter(authenticationBloc: authenticationBloc).router;
    final theme = AppTheme.light();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => userRepository,
        ),
        RepositoryProvider<ProfileRepository>(
          create: (_) => ProfileRepository(RemoteProfileProvider()),
        ),
        RepositoryProvider<AttendanceRepository>(
          create: (_) => AttendanceRepository(RemoteAttendanceProvider()),
        ),
        RepositoryProvider<MessageRepository>(
          create: (_) => MessageRepository(RemoteMessageProvider()),
        ),
      ],
      // value: userRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              userRepository: userRepository,
            ),
          ),
          BlocProvider<SignupBloc>(
            create: (context) => SignupBloc(
              userRepository: userRepository,
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              profileRepository: ProfileRepository(RemoteProfileProvider()),
            ),
          ),
          BlocProvider<AttendanceBloc>(
            create: (context) => AttendanceBloc(
              attendanceRepository:
                  AttendanceRepository(RemoteAttendanceProvider()),
            ),
          ),
          BlocProvider<MessageBloc>(
            create: (context) => MessageBloc(
              messageRepository: MessageRepository(RemoteMessageProvider()),
            ),
          ),
        ],
        child: MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          title: "Employee Management System",
          debugShowCheckedModeBanner: false,
          theme: theme,
        ),
      ),
    );
  }
}
