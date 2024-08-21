import 'package:equatable/equatable.dart';

class ParalysisState extends Equatable {
  final Map<String, String> fields;

  ParalysisState({required this.fields});

  ParalysisState copyWith({required Map<String, String> fields}) {
    return ParalysisState(fields: {...this.fields, ...fields});
  }

  @override
  List<Object> get props => [fields];
}
