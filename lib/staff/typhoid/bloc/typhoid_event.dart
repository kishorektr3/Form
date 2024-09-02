import 'package:equatable/equatable.dart';

abstract class TyphoidEvent extends Equatable {
  const TyphoidEvent();

  @override
  List<Object> get props => [];
}

class UpdateField extends TyphoidEvent {
  final String fieldName;
  final dynamic fieldValue;

  UpdateField(this.fieldName, this.fieldValue);

  @override
  List<Object> get props => [fieldName, fieldValue];
}

class UpdateMultipleSelectionField extends TyphoidEvent {
  final String fieldName;
  final List<String> selectedValues;

  UpdateMultipleSelectionField(this.fieldName, this.selectedValues);

  @override
  List<Object> get props => [fieldName, selectedValues];
}

class SubmitForm extends TyphoidEvent {}
