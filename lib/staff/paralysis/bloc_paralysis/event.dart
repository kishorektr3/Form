
import 'package:equatable/equatable.dart';

abstract class ParalysisEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateParalysisField extends ParalysisEvent {
  final String fieldName;
  final String fieldValue;

  UpdateParalysisField(this.fieldName, this.fieldValue);

  @override
  List<Object> get props => [fieldName, fieldValue];
}

class SubmitParalysisForm extends ParalysisEvent {}
