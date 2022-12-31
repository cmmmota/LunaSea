import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionTorrentCommandBar extends StatefulWidget {
  const TransmissionTorrentCommandBar({Key? key}) : super(key: key);

  @override
  State<TransmissionTorrentCommandBar> createState() => _State();
}

class _State extends State<TransmissionTorrentCommandBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransmissionState _state = context.read<TransmissionState>();

    return SizedBox(
        height: 50,
        child: ListView(
          padding: LunaUI.MARGIN_HALF_HORIZONTAL,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            // TransmissionAddTorrentCommandButton()
            // TransmissionRemoveTorrentCommandButton(),
            const Spacer(),
            TransmissionTorrentCommandBarResumeButton(tranmissionState: _state),
            TransmissionTorrentCommandBarPauseButton(tranmissionState: _state),
            const Spacer(),
            TransmissionTorrentCommandBarResumeAllButton(tranmissionState: _state),
            TransmissionTorrentCommandBarPauseAllButton(tranmissionState: _state),
          ],
        ));
  }
}
