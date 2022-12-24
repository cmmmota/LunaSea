import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/transmission.dart';

part 'torrent_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TransmissionTorrentRecord {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'queueposition')
  int? queuePosition;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(
    name: 'status',
    toJson: TransmissionUtilities.torrentStatusToJson,
    fromJson: TransmissionUtilities.torrentStatusFromJson,
  )
  TransmissionTorrentStatus? status;

  @JsonKey(name: 'isfinished')
  bool? isfinished;

  @JsonKey(name: 'percentDone')
  double? percentDone;

  @JsonKey(name: 'eta')
  double? eta;

  @JsonKey(name: 'etaidle')
  String? etaIdle;

  @JsonKey(
    name: 'error',
    toJson: TransmissionUtilities.torrentErrorToJson,
    fromJson: TransmissionUtilities.torrentErrorFromJson,
  )
  TransmissionTorrentError? error;

  @JsonKey(name: 'errorstring')
  String? timeleft;

  @JsonKey(name: 'metadatapercentcomplete')
  double? metadataPercentComplete;

  @JsonKey(name: 'peersconnected')
  int? peersConnected;

  @JsonKey(name: 'peerssendingtous')
  int? peersSendingToUs;

  @JsonKey(name: 'ratedownload')
  int? rateDownload;

  @JsonKey(name: 'rateupload')
  int? rateUpload;

  @JsonKey(name: 'totalsize')
  int? totalSize;

  @JsonKey(name: 'sizewhendone')
  int? sizeWhenDone;

  @JsonKey(name: 'uploadratio')
  int? uploadRatio;

  @JsonKey(name: 'addeddate')
  int? addedDate;

  TransmissionTorrentRecord(
      {this.id,
      this.queuePosition,
      this.name,
      this.status,
      this.isfinished,
      this.percentDone,
      this.eta,
      this.etaIdle,
      this.error,
      this.timeleft,
      this.metadataPercentComplete,
      this.peersConnected,
      this.peersSendingToUs,
      this.rateDownload,
      this.rateUpload,
      this.totalSize,
      this.sizeWhenDone,
      this.uploadRatio,
      this.addedDate});

  @override
  String toString() => json.encode(this.toJson());

  factory TransmissionTorrentRecord.fromJson(Map<String, dynamic> json) => _$TransmissionTorrentRecordFromJson(json);

  Map<String, dynamic> toJson() => _$TransmissionTorrentRecordToJson(this);
}
