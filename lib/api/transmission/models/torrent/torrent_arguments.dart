import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/transmission.dart';

part 'torrent_arguments.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TransmissionTorrentArguments {
  @JsonKey(name: 'torrents')
  List<TransmissionTorrentRecord>? torrents;

  TransmissionTorrentArguments({
    this.torrents,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory TransmissionTorrentArguments.fromJson(Map<String, dynamic> json) => _$TransmissionTorrentArgumentsFromJson(json);

  Map<String, dynamic> toJson() => _$TransmissionTorrentArgumentsToJson(this);
}
