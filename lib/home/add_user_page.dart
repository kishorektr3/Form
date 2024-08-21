import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adminbloccif/bloc/user_bloc.dart';
import 'package:adminbloccif/bloc/user_event.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  String? name, gender, dob, emailaddress, mobilenumber, status;
  int? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender'),
                onSaved: (value) => gender = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a gender' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date of Birth'),
                onSaved: (value) => dob = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter date of birth' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email Address'),
                onSaved: (value) => emailaddress = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email address' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mobile Number'),
                onSaved: (value) => mobilenumber = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter mobile number' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status'),
                onSaved: (value) => status = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter status' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                onSaved: (value) => age = int.tryParse(value ?? ''),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter age' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newUser = {
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'name': name,
                      'gender': gender,
                      'dob': dob,
                      'emailaddress': emailaddress,
                      'mobilenumber': mobilenumber,
                      'status': status,
                      'age': age,
                    };

                    context.read<UserBloc>().add(AddUser(newUser));
                    Navigator.pop(context);
                  }
                },
                child: Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
