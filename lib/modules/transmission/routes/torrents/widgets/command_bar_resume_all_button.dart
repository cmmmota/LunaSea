import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionTorrentCommandBarResumeAllButton extends StatefulWidget {
  final TransmissionState tranmissionState;

  const TransmissionTorrentCommandBarResumeAllButton({
    Key? key,
    required this.tranmissionState,
  }) : super(key: key);

  @override
  State<TransmissionTorrentCommandBarResumeAllButton> createState() => _State();
}

class _State extends State<TransmissionTorrentCommandBarResumeAllButton> {
  @override
  Widget build(BuildContext context) {
    return LunaButton(
      height: 30,
      iconSize: 30,
      type: LunaButtonType.ICON,
      alignment: Alignment.center,
      icon: Icons.play_arrow_sharp,
      color: widget.tranmissionState.selectedTorrent != null ? LunaColours.accent : LunaColours.grey,
      onTap: () => widget.tranmissionState.resumeAll(),
    );
  }
}
