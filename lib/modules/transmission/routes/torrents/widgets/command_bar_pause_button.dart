import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionTorrentCommandBarPauseButton extends StatefulWidget {
  final TransmissionState tranmissionState;

  const TransmissionTorrentCommandBarPauseButton({
    Key? key,
    required this.tranmissionState,
  }) : super(key: key);

  @override
  State<TransmissionTorrentCommandBarPauseButton> createState() => _State();
}

class _State extends State<TransmissionTorrentCommandBarPauseButton> {
  @override
  Widget build(BuildContext context) {
    return LunaButton(
      height: 30,
      iconSize: 30,
      type: LunaButtonType.ICON,
      alignment: Alignment.center,
      icon: Icons.pause,
      color: widget.tranmissionState.selectedTorrent != null ? LunaColours.accent : LunaColours.grey,
      onTap: () => widget.tranmissionState.pauseCurrent(),
    );
  }
}
