library transmission_utilities;

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionUtilities {
  TransmissionUtilities._();

  static TransmissionTorrentStatus? torrentStatusFromJson(int? state) => TransmissionTorrentStatus.DOWNLOAD.from(state);
  static String? torrentStatusToJson(TransmissionTorrentStatus? state) => state?.value;

  static TransmissionTorrentError? torrentErrorFromJson(int? state) => TransmissionTorrentError.OK.from(state);
  static String? torrentErrorToJson(TransmissionTorrentError? state) => state?.value;

  static IconData? torrentStatusToIcon(TransmissionTorrentStatus? status, TransmissionTorrentError? error) {
    if (error != TransmissionTorrentError.OK) {
      return LunaIcons.ERROR;
    }

    switch (status) {
      case TransmissionTorrentStatus.CHECK_WAIT:
      case TransmissionTorrentStatus.DOWNLOAD_WAIT:
      case TransmissionTorrentStatus.SEED_WAIT:
        return Icons.circle;
      case TransmissionTorrentStatus.CHECK:
        return LunaIcons.CONNECTION_TEST;
      case TransmissionTorrentStatus.DOWNLOAD:
        return Icons.download;
      case TransmissionTorrentStatus.STOPPED:
        return Icons.pause;
      case TransmissionTorrentStatus.SEED:
        return Icons.upload;
      default:
        return LunaIcons.TRANSMISSION;
    }
  }

  static foregroundColor(TransmissionTorrent torrent) {
    if (torrent.error != TransmissionTorrentError.OK) {
      return LunaColours.red;
    }

    switch (torrent.status) {
      case TransmissionTorrentStatus.SEED_WAIT:
      case TransmissionTorrentStatus.CHECK_WAIT:
      case TransmissionTorrentStatus.DOWNLOAD_WAIT:
      case TransmissionTorrentStatus.STOPPED:
        return LunaColours.grey;
      case TransmissionTorrentStatus.SEED:
        return LunaColours.blue;
      default:
        return LunaColours.accent;
    }
  }

  static double? percentDone(TransmissionTorrent torrent) {
    if (torrent.status == TransmissionTorrentStatus.SEED) {
      return torrent.uploadRatio;
    }

    return torrent.percentDone;
  }

  static Color backgroundColor(TransmissionTorrent torrent, Color canvasColor) {
    if (torrent.status == TransmissionTorrentStatus.SEED) {
      return LunaColours.accent;
    }

    return canvasColor;
  }

  static String? readablePercentDone(TransmissionTorrent torrent) {
    return '${(percentDone(torrent)! * 100).toStringAsFixed(2)}%';
  }
}
