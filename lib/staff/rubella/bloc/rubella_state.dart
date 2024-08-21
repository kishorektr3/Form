import 'package:equatable/equatable.dart';

class RubellaState extends Equatable {
  final Map<String, dynamic> fields;
  final String submissionStatus;

  RubellaState({required this.fields, this.submissionStatus = ''});

  RubellaState copyWith({
    Map<String, dynamic>? updatedFields,
    String? submissionStatus,
  }) {
    return RubellaState(
      fields: updatedFields ?? this.fields,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [fields, submissionStatus];
}

