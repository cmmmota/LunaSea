import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionTorrentStatisticsBar extends StatefulWidget {
  final TransmissionSessionStatistics statistics;

  const TransmissionTorrentStatisticsBar({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  @override
  State<TransmissionTorrentStatisticsBar> createState() => _State();
}

class _State extends State<TransmissionTorrentStatisticsBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            LunaText(text: '▾ ${this.widget.statistics.arguments!.downloadSpeed?.asReadableTransferRate()}', maxLines: 1),
            const Expanded(child: SizedBox(width: 10)),
            LunaText(text: '▴ ${this.widget.statistics.arguments!.uploadSpeed?.asReadableTransferRate()}'),
            const Expanded(child: SizedBox(width: 15)),
          ],
        ));
  }
}
