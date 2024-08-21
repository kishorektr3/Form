import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adminbloccif/bloc/user_bloc.dart';
import 'package:adminbloccif/bloc/user_event.dart';

class EditPageFormUser extends StatefulWidget {
  final Map<String, dynamic> user;

  EditPageFormUser({required this.user});

  @override
  _EditPageFormUserState createState() => _EditPageFormUserState();
}

class _EditPageFormUserState extends State<EditPageFormUser> {
  final _formKey = GlobalKey<FormState>();
  late String name, gender, dob, emailaddress, mobilenumber, status;
  late int age;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    name = user['name'];
    gender = user['gender'];
    dob = user['dob'];
    emailaddress = user['emailaddress'];
    mobilenumber = user['mobilenumber'];
    status = user['status'];
    age = user['age'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                initialValue: gender,
                decoration: InputDecoration(labelText: 'Gender'),
                onSaved: (value) => gender = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a gender' : null,
              ),
              TextFormField(
                initialValue: dob,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                onSaved: (value) => dob = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter date of birth' : null,
              ),
              TextFormField(
                initialValue: emailaddress,
                decoration: InputDecoration(labelText: 'Email Address'),
                onSaved: (value) => emailaddress = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email address' : null,
              ),
              TextFormField(
                initialValue: mobilenumber,
                decoration: InputDecoration(labelText: 'Mobile Number'),
                onSaved: (value) => mobilenumber = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter mobile number' : null,
              ),
              TextFormField(
                initialValue: status,
                decoration: InputDecoration(labelText: 'Status'),
                onSaved: (value) => status = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter status' : null,
              ),
              TextFormField(
                initialValue: age.toString(),
                decoration: InputDecoration(labelText: 'Age'),
                onSaved: (value) => age = int.tryParse(value!)!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter age' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final updatedUser = {
                      'id': widget.user['id'],
                      'name': name,
                      'gender': gender,
                      'dob': dob,
                      'emailaddress': emailaddress,
                      'mobilenumber': mobilenumber,
                      'status': status,
                      'age': age,
                    };

                    context.read<UserBloc>().add(UpdateUser(updatedUser));
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
