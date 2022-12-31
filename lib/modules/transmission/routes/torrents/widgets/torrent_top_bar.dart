import 'package:flutter/material.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionTorrentTopBar extends StatefulWidget {
  const TransmissionTorrentTopBar({Key? key, required this.statistics}) : super(key: key);
  final TransmissionSessionStatistics statistics;

  @override
  State<TransmissionTorrentTopBar> createState() => _State();
}

class _State extends State<TransmissionTorrentTopBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TransmissionTorrentCommandBar(),
        TransmissionTorrentStatisticsBar(
          statistics: this.widget.statistics,
        )
      ],
    );
  }
}
