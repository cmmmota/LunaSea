import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/transmission.dart';

part 'session_statistics_arguments.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TransmissionSessionStatisticsArguments {
  @JsonKey(name: 'activeTorrentCount')
  int? activeTorrentCount;

  @JsonKey(name: 'downloadSpeed')
  int? downloadSpeed;

  @JsonKey(name: 'pausedTorrentCount')
  int? pausedTorrentCount;

  @JsonKey(name: 'torrentCount')
  int? torrentCount;

  @JsonKey(name: 'uploadSpeed')
  int? uploadSpeed;

  TransmissionSessionStatisticsArguments({this.activeTorrentCount, this.downloadSpeed, this.pausedTorrentCount, this.torrentCount, this.uploadSpeed});

  @override
  String toString() => json.encode(this.toJson());

  factory TransmissionSessionStatisticsArguments.fromJson(Map<String, dynamic> json) => _$TransmissionSessionStatisticsArgumentsFromJson(json);

  Map<String, dynamic> toJson() => _$TransmissionSessionStatisticsArgumentsToJson(this);
}
