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
        return Icons.pause_circle;
      case TransmissionTorrentStatus.CHECK:
        return LunaIcons.CONNECTION_TEST;
      case TransmissionTorrentStatus.DOWNLOAD:
        return Icons.download;
      case TransmissionTorrentStatus.STOPPED:
        return Icons.stop;
      case TransmissionTorrentStatus.SEED:
        return Icons.upload;
      default:
        return LunaIcons.TRANSMISSION;
    }
  }
}
