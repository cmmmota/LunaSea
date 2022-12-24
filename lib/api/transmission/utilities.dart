library transmission_utilities;

import 'package:lunasea/modules/transmission.dart';

class TransmissionUtilities {
  TransmissionUtilities._();

  static TransmissionTorrentStatus? torrentStatusFromJson(String? state) => TransmissionTorrentStatus.DOWNLOAD.from(state);
  static String? torrentStatusToJson(TransmissionTorrentStatus? state) => state?.value;

  static TransmissionTorrentError? torrentErrorFromJson(String? state) => TransmissionTorrentError.OK.from(state);
  static String? torrentErrorToJson(TransmissionTorrentError? state) => state?.value;
}
