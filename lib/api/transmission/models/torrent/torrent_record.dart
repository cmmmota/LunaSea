import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/transmission.dart';

part 'torrent_record.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TransmissionTorrent {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'queuePosition')
  int? queuePosition;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(
    name: 'status',
    toJson: TransmissionUtilities.torrentStatusToJson,
    fromJson: TransmissionUtilities.torrentStatusFromJson,
  )
  TransmissionTorrentStatus? status;

  @JsonKey(name: 'isFinished')
  bool? isfinished;

  @JsonKey(name: 'percentDone')
  double? percentDone;

  @JsonKey(name: 'eta')
  double? eta;

  @JsonKey(name: 'etaIdle')
  int? etaIdle;

  @JsonKey(
    name: 'error',
    toJson: TransmissionUtilities.torrentErrorToJson,
    fromJson: TransmissionUtilities.torrentErrorFromJson,
  )
  TransmissionTorrentError? error;

  @JsonKey(name: 'errorString')
  String? errorString;

  @JsonKey(name: 'timeLeft')
  int? timeleft;

  @JsonKey(name: 'metadataPercentComplete')
  double? metadataPercentComplete;

  @JsonKey(name: 'peersConnected')
  int? peersConnected;

  @JsonKey(name: 'peersSendingToUs')
  int? peersSendingToUs;

  @JsonKey(name: 'rateDownload')
  int? rateDownload;

  @JsonKey(name: 'rateUpload')
  int? rateUpload;

  @JsonKey(name: 'totalSize')
  int? totalSize;

  @JsonKey(name: 'sizeWhenDone')
  int? sizeWhenDone;

  @JsonKey(name: 'uploadRatio')
  double? uploadRatio;

  @JsonKey(name: 'addedDate')
  int? addedDate;

  bool isSelected = false;

  TransmissionTorrent(
      {this.id,
      this.queuePosition,
      this.name,
      this.status,
      this.isfinished,
      this.percentDone,
      this.eta,
      this.etaIdle,
      this.error,
      this.errorString,
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

  factory TransmissionTorrent.fromJson(Map<String, dynamic> json) => _$TransmissionTorrentFromJson(json);

  Map<String, dynamic> toJson() => _$TransmissionTorrentToJson(this);

  IconData? toIcon() => TransmissionUtilities.torrentStatusToIcon(this.status, this.error);

  String? readableRateUpload() {
    return this.rateUpload.asReadableTransferRate();
  }

  String? readableRateDownload() {
    return this.rateDownload.asReadableTransferRate();
  }

  String? statusDescription() {
    if (this.isfinished == true) {
      return 'transmission.Done'.tr();
    }

    return this.status!.value!;
  }

  String? readableDownloaded() {
    int? bytes = 0;

    if (this.percentDone! > 0) {
      bytes = (this.sizeWhenDone!.toDouble() * this.percentDone!).toInt();
    }

    return bytes.asReadableSize();
  }

  String? readableTotalSize() {
    return this.sizeWhenDone.asReadableSize();
  }

  String? readableDownloadedOrUploaded() {
    if (this.percentDone! < 1) {
      return this.readableDownloaded();
    } else {
      return this.readableUploaded();
    }
  }

  String? readableUploaded() {
    int? bytes = 0;

    if (this.uploadRatio! > 0) {
      bytes = (this.sizeWhenDone!.toDouble() * this.uploadRatio!).toInt();
    }

    return bytes.asReadableSize();
  }
}
