import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/transmission.dart';

part 'session_arguments.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TransmissionSessionArguments {
  @JsonKey(name: 'fields')
  List<String>? fields;

  TransmissionSessionArguments({
    this.fields,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory TransmissionSessionArguments.fromJson(Map<String, dynamic> json) => _$TransmissionSessionArgumentsFromJson(json);

  Map<String, dynamic> toJson() => _$TransmissionSessionArgumentsToJson(this);
}
