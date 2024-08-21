// States
import 'package:equatable/equatable.dart';

abstract class DiseaseState extends Equatable {
  const DiseaseState();

  @override
  List<Object> get props => [];
}

class InitialDiseaseState extends DiseaseState {}

class DiseaseScreenState extends DiseaseState {
  final DiseaseScreenType diseaseScreenType;

  const DiseaseScreenState(this.diseaseScreenType);

  @override
  List<Object> get props => [diseaseScreenType];
}

enum DiseaseScreenType {
  Paralysis,
  IvdpvSurveillance,
  Rubella,
  Typhoid,
  VaccinePreventable,
}