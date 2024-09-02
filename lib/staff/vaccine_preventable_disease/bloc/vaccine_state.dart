import 'package:equatable/equatable.dart';

class VaccineState extends Equatable {
  final Map<String, dynamic> fields;
  final String submissionStatus;

 VaccineState({required this.fields, this.submissionStatus = ''});

 VaccineState copyWith({
    Map<String, dynamic>? updatedFields,
    String? submissionStatus,
  }) {
    return VaccineState(
      fields: updatedFields ?? this.fields,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [fields, submissionStatus];
}

