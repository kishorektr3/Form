import 'package:equatable/equatable.dart';

class IvdvState extends Equatable {
  final Map<String, String> fields;

  IvdvState({required this.fields});

  IvdvState copyWith(
      {required Map<String, String> updatedFields}) {
    return IvdvState(fields: {...fields, ...updatedFields});
  }
  @override
  List<Object> get props => [
    fields,
  ];
}
