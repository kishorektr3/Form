import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adminbloccif/bloc/user_bloc.dart';
import 'package:adminbloccif/bloc/user_event.dart';
import 'package:adminbloccif/bloc/user_state.dart';
import 'edit_page.dart';
import 'add_user_page.dart';

class ListPageFormUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(FetchUsers());

    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['emailaddress']),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPageFormUser(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is UserFailure) {
            return Center(child: Text(state.error));
          }
          return Center(child: Text('No users found'));
        },
      ),
    );
  }
}
