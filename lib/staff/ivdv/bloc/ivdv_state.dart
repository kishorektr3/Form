import 'package:equatable/equatable.dart';

class IvdvState extends Equatable {
  final Map<String, dynamic> fields;
  final String submissionStatus;

  IvdvState({required this.fields, this.submissionStatus = ''});

  IvdvState copyWith({
    Map<String, dynamic>? updatedFields,
    String? submissionStatus,
  }) {
    return IvdvState(
      fields: updatedFields ?? this.fields,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [fields, submissionStatus];
}

