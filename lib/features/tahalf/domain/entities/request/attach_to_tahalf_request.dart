// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AttachToTahalfRequest extends Equatable {
  final int userId;
  final int tahalfID;
  final String? password;
  const AttachToTahalfRequest({
    required this.userId,
    required this.tahalfID,
    this.password,
  });

  @override
  List<Object?> get props {
    return [tahalfID, userId, password];
  }
}
