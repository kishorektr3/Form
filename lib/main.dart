import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adminbloccif/bloc/auth_bloc.dart';
import 'package:adminbloccif/bloc/auth_repository.dart';
import 'package:adminbloccif/login/login_screen.dart';
import 'package:adminbloccif/home/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        // Add other BLoCs here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          '/homepage': (context) => HomePage(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
