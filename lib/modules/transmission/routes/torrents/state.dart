import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionTorrentsState extends ChangeNotifier {
  TransmissionTorrentsState(BuildContext context) {
    fetchTorrents(context);
  }

  Timer? _timer;
  void cancelTimer() => _timer?.cancel();
  void createTimer(BuildContext context) {
    _timer = Timer.periodic(
      Duration(seconds: TransmissionDatabase.TORRENT_REFRESH_RATE.read()),
      (_) => fetchTorrents(context),
    );
  }

  late Future<TransmissionTorrentList> _torrents;
  Future<TransmissionTorrentList> get torrents => _torrents;
  set torrents(Future<TransmissionTorrentList> torrents) {
    this.torrents = torrents;
    notifyListeners();
  }

  Future<void> fetchTorrents(
    BuildContext context,
  ) async {
    cancelTimer();
    if (context.read<TransmissionState>().enabled) {
      _torrents = context.read<TransmissionState>().api!.torrent.get();
      createTimer(context);
    }
    notifyListeners();
  }
}
