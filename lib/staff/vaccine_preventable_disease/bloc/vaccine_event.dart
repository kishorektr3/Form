abstract class VaccineEvent {}

class UpdateVaccineField extends VaccineEvent {
  final String fieldName;
  final String fieldValue;

  UpdateVaccineField(this.fieldName, this.fieldValue);
}

class SubmitVaccineForm extends VaccineEvent {}
