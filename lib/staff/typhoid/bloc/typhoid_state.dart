import 'package:equatable/equatable.dart';

class TyphoidState extends Equatable {
  final Map<String, dynamic> fields;
  final String submissionStatus;

  TyphoidState({required this.fields, this.submissionStatus = ''});

  TyphoidState copyWith({
    Map<String, dynamic>? updatedFields,
    String? submissionStatus,
  }) {
    return TyphoidState(
      fields: updatedFields ?? this.fields,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [fields, submissionStatus];
}

