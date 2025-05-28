import 'package:final_2025/blocs/auth_bloc/authentication_bloc.dart';
import 'package:final_2025/models/my_user.dart';
import 'package:final_2025/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthRepository _provider = AuthRepository();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    MyUser user = MyUser(userId: '', username: username, email: email);

    context.read<AuthenticationBloc>().add(
          EmailSignupRequested(user: user, password: password),
        );
  }

  void signUpWithGoogle() {
    context.read<AuthenticationBloc>().add(GoogleSignupRequested());

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is EmailSignupRequestedSuccess) {
          if (state.myUser != null) {
            context.go('/home');
          }
        }
        if (state is GoogleSignUpSuccess) {
          context
              .read<AuthenticationBloc>()
              .add(SaveUserToFirestore(user: state.myUser));
          context.go('/home');
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text('Sign Up'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    label: Text('Username'),
                    hintText: 'Awesome Possum',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    hintText: 'abc@xyz.com',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    hintText: '',
                    helperText: 'Must have atleast six characters',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    signUp();
                  },
                  child: const Text('Sign Up')),
              TextButton(
                  onPressed: () {
                    signUpWithGoogle();
                  },
                  child: const Text('Sign In With Google')),
            ],
          ),
        )),
      ),
    );
  }
}
