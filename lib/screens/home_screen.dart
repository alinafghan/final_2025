import 'package:final_2025/blocs/auth_bloc/authentication_bloc.dart';
import 'package:final_2025/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthenticationBloc>().add(Logout());
              context.go('/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Screen!',
                style: TextStyle(fontSize: 24)),
            TextButton(
              onPressed: () {
                context.push('/home/firebase'); // Navigate to a feature screen
              }, // Placeholder for future functionality
              child: Text('question one'),
            ),
            TextButton(
              onPressed: () {
                context.push('/home/static'); // Navigate to a feature screen
              }, // Placeholder for future functionality
              child: Text('question two'),
            ),
          ],
        ),
      ),
    );
  }
}
