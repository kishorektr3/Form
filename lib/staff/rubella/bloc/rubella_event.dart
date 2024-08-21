import 'package:equatable/equatable.dart';

abstract class RubellaEvent extends Equatable {
  const RubellaEvent();

  @override
  List<Object> get props => [];
}

class UpdateField extends RubellaEvent {
  final String fieldName;
  final dynamic fieldValue;

  UpdateField(this.fieldName, this.fieldValue);

  @override
  List<Object> get props => [fieldName, fieldValue];
}

class SubmitForm extends RubellaEvent {}
