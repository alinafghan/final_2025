import 'package:final_2025/blocs/auth_bloc/authentication_bloc.dart';
import 'package:final_2025/blocs/data_cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  final TextEditingController idController = TextEditingController();

  @override
  void initState() {
    context.read<DataCubit>().getAllData();
    super.initState();
  }

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
            const Text('Welcome to the All Data Screen!',
                style: TextStyle(fontSize: 24)),
            TextButton(
              onPressed: () {
                context.pop();
              }, // Placeholder for future functionality
              child: Text('back'),
            ),
            BlocBuilder<DataCubit, DataState>(
              builder: (context, state) {
                if (state is GetAllDataLoading) {
                  return const CircularProgressIndicator();
                } else if (state is GetAllDataLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        final data = state.list[index];
                        return ListTile(
                          title: Text(data.name),
                          subtitle: Text(data.description),
                          // leading: data.imageUrl.isNotEmpty
                          //     ? Image.network(data.imageUrl)
                          //     : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  context.go('/home/update', extra: data);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context.read<DataCubit>().deleteData(data.id);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is GetAllDataError) {
                  return Text('Error:}');
                }
                return const Text('No data available');
              },
            ),
          ],
        ),
      ),
    );
  }
}
