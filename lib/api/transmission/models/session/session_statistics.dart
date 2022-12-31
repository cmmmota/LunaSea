import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/transmission.dart';

part 'session_statistics.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TransmissionSessionStatistics {
  @JsonKey(name: 'arguments')
  TransmissionSessionStatisticsArguments? arguments;

  @JsonKey(name: 'result')
  String? result;

  TransmissionSessionStatistics({
    this.arguments,
    this.result,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory TransmissionSessionStatistics.fromJson(Map<String, dynamic> json) => _$TransmissionSessionStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$TransmissionSessionStatisticsToJson(this);
}
