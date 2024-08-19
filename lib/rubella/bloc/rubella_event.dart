// form_event.dart

abstract class RubellaEvent {}

class UpdateField extends RubellaEvent {
  final String fieldName;
  final dynamic fieldValue;

  UpdateField(this.fieldName, this.fieldValue);
}

class SubmitForm extends RubellaEvent {}
