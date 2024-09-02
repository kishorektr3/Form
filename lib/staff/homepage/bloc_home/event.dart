import 'package:equatable/equatable.dart';
import 'package:untitled/staff/homepage/bloc_home/state.dart';


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