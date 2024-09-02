import 'package:equatable/equatable.dart';

abstract class ParalysisEvent extends Equatable {
  const ParalysisEvent();

  @override
  List<Object> get props => [];
}

class UpdateField extends ParalysisEvent {
  final String fieldName;
  final dynamic fieldValue;

  UpdateField(this.fieldName, this.fieldValue);

  @override
  List<Object> get props => [fieldName, fieldValue];
}

class SubmitForm extends ParalysisEvent {}
