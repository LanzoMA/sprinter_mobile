import 'package:go_router/go_router.dart';
import 'package:sprinter_mobile/pages/settings/change_email_page.dart';
import 'package:sprinter_mobile/pages/login_page.dart';
import 'package:sprinter_mobile/pages/main_page.dart';
import 'package:sprinter_mobile/pages/settings/change_password_page.dart';
import 'package:sprinter_mobile/pages/settings/delete_account_page.dart';
import 'package:sprinter_mobile/pages/settings/settings_page.dart';
import 'package:sprinter_mobile/pages/sign_up_page.dart';
import 'package:sprinter_mobile/utils/secure_storage.dart';

final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final String? token = await getAccessToken();

    final bool onAuthPage =
        state.fullPath == '/login' || state.fullPath == '/signup';

    if (token != null && onAuthPage) {
      return '/settings';
    }

    if (token == null && !onAuthPage) {
      return '/login';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainPage(index: 0),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const MainPage(index: 1),
    ),
    GoRoute(
      path: '/upload',
      builder: (context, state) => const MainPage(index: 2),
    ),
    GoRoute(
      path: '/saved',
      builder: (context, state) => const MainPage(index: 3),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const MainPage(index: 4),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/settings/account/email',
      builder: (context, state) => const ChangeEmailPage(),
    ),
    GoRoute(
      path: '/settings/account/password',
      builder: (context, state) => const ChangePasswordPage(),
    ),
    GoRoute(
      path: '/settings/account/delete',
      builder: (context, state) => const DeleteAccountPage(),
    ),
  ],
);
