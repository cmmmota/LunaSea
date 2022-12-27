part of transmission_types;

enum TransmissionTorrentStatus {
  STOPPED,
  CHECK_WAIT,
  CHECK,
  DOWNLOAD_WAIT,
  DOWNLOAD,
  SEED_WAIT,
  SEED,
}

extension TransmissionTorrentStatusExtension on TransmissionTorrentStatus {
  TransmissionTorrentStatus? from(int? type) {
    switch (type) {
      case 0:
        return TransmissionTorrentStatus.STOPPED;
      case 1:
        return TransmissionTorrentStatus.CHECK_WAIT;
      case 2:
        return TransmissionTorrentStatus.CHECK;
      case 3:
        return TransmissionTorrentStatus.DOWNLOAD_WAIT;
      case 4:
        return TransmissionTorrentStatus.DOWNLOAD;
      case 5:
        return TransmissionTorrentStatus.SEED_WAIT;
      case 6:
        return TransmissionTorrentStatus.SEED;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case TransmissionTorrentStatus.STOPPED:
        return 'Paused';
      case TransmissionTorrentStatus.CHECK_WAIT:
        return 'Queued to check files';
      case TransmissionTorrentStatus.CHECK:
        return 'Checking files ';
      case TransmissionTorrentStatus.DOWNLOAD_WAIT:
        return 'Queued to download';
      case TransmissionTorrentStatus.DOWNLOAD:
        return 'Downloading';
      case TransmissionTorrentStatus.SEED_WAIT:
        return 'Queued to seed';
      case TransmissionTorrentStatus.SEED:
        return 'Seeding';
      default:
        return null;
    }
  }
}
