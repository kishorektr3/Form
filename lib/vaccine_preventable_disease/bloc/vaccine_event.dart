import 'package:equatable/equatable.dart';

abstract class VaccineEvent extends Equatable {
  const VaccineEvent();

  @override
  List<Object> get props => [];
}

class UpdateField extends VaccineEvent {
  final String fieldName;
  final dynamic fieldValue;

  UpdateField(this.fieldName, this.fieldValue);

  @override
  List<Object> get props => [fieldName, fieldValue];
}

class SubmitForm extends VaccineEvent {}
