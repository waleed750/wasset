import 'package:equatable/equatable.dart';

class Pivot extends Equatable {
  final int? allianceId;
  final int? userId;

  const Pivot({this.allianceId, this.userId});

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        allianceId: json['alliance_id'] as int?,
        userId: json['user_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'alliance_id': allianceId,
        'user_id': userId,
      };

  @override
  List<Object?> get props => [allianceId, userId];
}
