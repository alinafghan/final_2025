import 'package:final_2025/blocs/auth_bloc/authentication_bloc.dart';
import 'package:final_2025/blocs/data_cubit/data_cubit.dart';
import 'package:final_2025/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NextScreen extends StatelessWidget {
  NextScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

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
                context.pop();
              }, // Placeholder for future functionality
              child: Text('back'),
            ),
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: descriptionController,
            ),
            TextField(
              controller: imageUrlController,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<DataCubit>().saveData(
                      Data(
                        id: '',
                        name: nameController.text,
                        description: descriptionController.text,
                        imageUrl: imageUrlController.text,
                      ),
                    );
                // Here you would typically save the data to a repository
                // For now, we just print it to the console
                print('Name: ${nameController.text}');
                print('Description: ${descriptionController.text}');
                print('Image URL: ${imageUrlController.text}');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
