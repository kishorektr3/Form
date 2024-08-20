import 'package:equatable/equatable.dart';

class ParalysisState extends Equatable {
  final Map<String, dynamic> fields;
  final String submissionStatus;

  ParalysisState({required this.fields, this.submissionStatus = ''});

  ParalysisState copyWith({
    Map<String, dynamic>? updatedFields,
    String? submissionStatus,
  }) {
    return ParalysisState(
      fields: updatedFields ?? this.fields,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [fields, submissionStatus];
}

