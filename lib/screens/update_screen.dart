import 'package:final_2025/blocs/auth_bloc/authentication_bloc.dart';
import 'package:final_2025/blocs/data_cubit/data_cubit.dart';
import 'package:final_2025/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key});
  final TextEditingController idController = TextEditingController();
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
            const Text('Welcome to the Update Data Screen!',
                style: TextStyle(fontSize: 24)),
            TextButton(
              onPressed: () {
                context.pop();
              }, // Placeholder for future functionality
              child: Text('back'),
            ),
            TextField(
              controller: idController,
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
                context.read<DataCubit>().updateData(
                      Data(
                        id: idController.text,
                        name: nameController.text,
                        description: descriptionController.text,
                        imageUrl: imageUrlController.text,
                      ),
                    );
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
