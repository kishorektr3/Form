import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled/staff/paralysis/bloc_paralysis/bloc.dart';
import 'package:untitled/staff/paralysis/paralysis.dart';
import 'package:untitled/staff/rubella/bloc/rubella_bloc.dart';

import 'package:untitled/staff/rubella/view/rubella.dart';
import 'package:untitled/staff/typhoid/bloc/typhoid_bloc.dart';
import 'package:untitled/staff/typhoid/view/typhoid.dart';
import 'package:untitled/staff/vaccine_preventable_disease/bloc/vaccine_bloc.dart';
import 'package:untitled/staff/vaccine_preventable_disease/view/vaccine.dart';

import 'HomePage/bloc_home/bloc.dart';
import 'HomePage/view/DiseaseScreen.dart';
import 'staff/ivdv/bloc/ivdv_bloc.dart';
import 'staff/ivdv/view/ivdv.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DiseaseBloc>(
          create: (_) => DiseaseBloc(),
        ),
        BlocProvider<ParalysisBloc>(
          create: (_) => ParalysisBloc(),
        ),
        BlocProvider<TyphoidBloc>(
          create: (_) => TyphoidBloc(),
        ),
        BlocProvider<RubellaBloc>(
          create: (_) => RubellaBloc(),
        ),
        BlocProvider<IvdvBloc>(
          create: (_) => IvdvBloc(),
        ),
        BlocProvider<VaccineBloc>(
          create: (_) => VaccineBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DiseaseScreen(),
        routes: {
          '/Paralysis': (context) => Paralysis(),
          '/Rubella': (context) => Rubella(),
          '/Typhoid': (context) => Typhoid(),
          '/Ivdv': (context) => Ivdv(),
          '/Vaccine': (context) => Vaccine(),


          // Add other routes if needed
        },
      ),
    );
  }
}