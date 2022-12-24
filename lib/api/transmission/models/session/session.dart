import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/transmission.dart';

part 'session.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TransmissionSession {
  @JsonKey(name: 'arguments')
  TransmissionSessionArguments? arguments;

  @JsonKey(name: 'result')
  String? result;

  TransmissionSession({
    this.arguments,
    this.result,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory TransmissionSession.fromJson(Map<String, dynamic> json) => _$TransmissionSessionFromJson(json);

  Map<String, dynamic> toJson() => _$TransmissionSessionToJson(this);
}
