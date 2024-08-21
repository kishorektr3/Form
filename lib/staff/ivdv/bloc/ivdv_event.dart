import 'package:equatable/equatable.dart';

abstract class IvdvEvent extends Equatable {
  const IvdvEvent();

  @override
  List<Object> get props => [];
}

class UpdateField extends IvdvEvent {
  final String fieldName;
  final dynamic fieldValue;

  UpdateField(this.fieldName, this.fieldValue);

  @override
  List<Object> get props => [fieldName, fieldValue];
}

class SubmitForm extends IvdvEvent {}
