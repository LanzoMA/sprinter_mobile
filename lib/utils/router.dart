import 'package:go_router/go_router.dart';
import 'package:sprinter_mobile/pages/login_page.dart';
import 'package:sprinter_mobile/pages/main_page.dart';
import 'package:sprinter_mobile/pages/sign_up_page.dart';

final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async => null,
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
  ],
);
