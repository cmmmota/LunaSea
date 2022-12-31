import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionTorrentCommandBarPauseAllButton extends StatefulWidget {
  final TransmissionState tranmissionState;

  const TransmissionTorrentCommandBarPauseAllButton({
    Key? key,
    required this.tranmissionState,
  }) : super(key: key);

  @override
  State<TransmissionTorrentCommandBarPauseAllButton> createState() => _State();
}

class _State extends State<TransmissionTorrentCommandBarPauseAllButton> {
  @override
  Widget build(BuildContext context) {
    return LunaButton(
      height: 30,
      iconSize: 30,
      type: LunaButtonType.ICON,
      alignment: Alignment.center,
      icon: Icons.pause_sharp,
      color: widget.tranmissionState.selectedTorrent != null ? LunaColours.accent : LunaColours.grey,
      onTap: () => widget.tranmissionState.pauseAll(),
    );
  }
}
