import 'package:final_2025/blocs/bloc/authentication_bloc.dart';
import 'package:final_2025/repositories/auth_repository.dart';
import 'package:final_2025/screens/home_screen.dart';
import 'package:final_2025/screens/next_screen.dart';
import 'package:final_2025/screens/signup_screen.dart';
import 'package:final_2025/screens/login_screen.dart';
import 'package:final_2025/screens/splash_screen.dart';
import 'package:final_2025/utils/StreamToListenable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = AuthenticationBloc(
      authRepository: AuthRepository(),
    );

    final GoRouter router = GoRouter(
      refreshListenable: StreamToListenable([authBloc.stream]),
      //The top-level callback allows the app to redirect to a new location.
      redirect: (context, state) {
        final isAuthenticated =
            authBloc.state.status == AuthenticationStatus.authenticated;
        final isUnAuthenticated =
            authBloc.state.status == AuthenticationStatus.unauthenticated;

        final loggingIn = state.matchedLocation == '/login' ||
            state.matchedLocation == '/signup';

        if (isUnAuthenticated && !loggingIn) {
          return '/login';
        }
        if (isAuthenticated && (state.matchedLocation == '/' || loggingIn)) {
          return '/home';
        }

        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'home',
              builder: (BuildContext context, GoRouterState state) {
                return BlocProvider(
                  create: (context) =>
                      AuthenticationBloc(authRepository: AuthRepository()),
                  child: const HomeScreen(),
                );
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'next',
                  builder: (BuildContext context, GoRouterState state) {
                    return BlocProvider(
                      create: (context) =>
                          AuthenticationBloc(authRepository: AuthRepository()),
                      child: const NextScreen(),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'login',
              builder: (BuildContext context, GoRouterState state) {
                return const LoginScreen();
              },
            ),
            GoRoute(
              path: 'signup',
              builder: (BuildContext context, GoRouterState state) {
                return BlocProvider(
                  create: (context) =>
                      AuthenticationBloc(authRepository: AuthRepository()),
                  child: const SignupScreen(),
                );
              },
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
