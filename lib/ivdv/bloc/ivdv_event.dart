// form_event.dart
abstract class IvdvEvent {}

class UpdateField extends IvdvEvent {
  final String fieldName;
  final String fieldValue;

  UpdateField(this.fieldName, this.fieldValue);
}

class SubmitForm extends IvdvEvent {}
