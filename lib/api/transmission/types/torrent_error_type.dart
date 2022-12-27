part of transmission_types;

enum TransmissionTorrentError {
  OK,
  TRACKER_WARNING,
  TRACKER_ERROR,
  LOCAL_ERROR,
}

extension TransmissionTorrentErrorExtension on TransmissionTorrentError {
  TransmissionTorrentError? from(int? type) {
    switch (type) {
      case 0:
        return TransmissionTorrentError.OK;
      case 1:
        return TransmissionTorrentError.TRACKER_WARNING;
      case 2:
        return TransmissionTorrentError.TRACKER_ERROR;
      case 3:
        return TransmissionTorrentError.LOCAL_ERROR;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case TransmissionTorrentError.OK:
        return 'Ok';
      case TransmissionTorrentError.TRACKER_WARNING:
        return 'Tracker warning';
      case TransmissionTorrentError.TRACKER_ERROR:
        return 'Tracker error';
      case TransmissionTorrentError.LOCAL_ERROR:
        return 'Local error';
      default:
        return null;
    }
  }
}
