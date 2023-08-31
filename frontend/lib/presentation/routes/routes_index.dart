import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../presentation_index.dart';
import 'constants.dart';
import '../../application/application_index.dart';

class MyRouter {
  final AuthenticationBloc authenticationBloc;
  MyRouter({required this.authenticationBloc});

  late final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(authenticationBloc.stream),
    debugLogDiagnostics: true,
    // urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const WelcomeScreen(),
        ),
      ),
      GoRoute(
        name: loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        name: createAccountRouteName,
        path: '/create-account',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: SignupScreen(),
        ),
      ),
      // the following are all the pages related to the owner
      GoRoute(
        name: ownerDashboard,
        path: '/owner-dashboard',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: OwnerDashboard(),
        ),
      ),
      GoRoute(
        name: managerDashboard,
        path: '/manager-dashboard',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ManagerDashboard(),
        ),
      ),
      //employee specific routes
      GoRoute(
        name: employeeDashboard,
        path: '/employee-dashboard',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: EmployeeDashboard(),
        ),
      ),
      GoRoute(
        name: applicantsRouteName,
        path: '/applicants',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: SignupApplicants(),
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ViewProfile(),
        ),
      ),
      GoRoute(
        path: '/edit-profile',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: EditProfile(),
        ),
      ),
      GoRoute(
        name: attendancesRouteName,
        path: '/attendance',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: EmployeeAttendance(),
        ),
      ),

      GoRoute(
        path: '/employees-list',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: EmployeesList(),
        ),
      ),

      //manager specific routers

      GoRoute(
        path: '/attendance-check',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: AttendanceCheck(),
        ),
      ),

      GoRoute(
        name: newAnnouncementRouteName,
        path: '/create-announcement',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: SendNotification(),
        ),
      ),

      GoRoute(
        name: notificationsRouteName,
        path: '/notifications',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: NotificationListScreen(),
        ),
      ),

      // GoRoute(
      //   path: '/notification-details',
      //   pageBuilder: (context, state) => MaterialPage<void>(
      //     key: state.pageKey,
      //     child: NotificationDetailsScreen(),
      //   ),
      // ),

      GoRoute(
        path: '/sent-notifications',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: SentNotificationListScreen(),
        ),
      ),
      GoRoute(
        path: '/update-notification',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: UpdateNotificationDetail(),
        ),
      ),

      // ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
    // redirect: (state) {
    //   if (state.isAuthenticated) {
    //     return rootRouteName;
    //   }
    //   {
    //     return loginRouteName;
    //   }
    // },
  );
}
