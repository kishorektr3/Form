import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/HomePage/bloc_home/state.dart';


// Events
abstract class DiseaseEvent extends Equatable {
  const DiseaseEvent();

  @override
  List<Object> get props => [];
}

class SelectDiseaseEvent extends DiseaseEvent {
  final DiseaseScreenType diseaseScreenType;

  const SelectDiseaseEvent(this.diseaseScreenType);

  @override
  List<Object> get props => [diseaseScreenType];
}