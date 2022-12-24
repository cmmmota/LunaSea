import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/transmission.dart';

part 'torrents.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TransmissionTorrentList {
  @JsonKey(name: 'arguments')
  TransmissionTorrentArguments? arguments;

  @JsonKey(name: 'result')
  String? result;

  TransmissionTorrentList({
    this.arguments,
    this.result,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory TransmissionTorrentList.fromJson(Map<String, dynamic> json) => _$TransmissionTorrentListFromJson(json);

  Map<String, dynamic> toJson() => _$TransmissionTorrentListToJson(this);
}
