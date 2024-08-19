
class VaccineState {
  final Map<String, String> fields;

  VaccineState({required this.fields});

  VaccineState copyWith({Map<String, String>? fields}) {
    return VaccineState(
      fields: fields ?? this.fields,
    );
  }
}
