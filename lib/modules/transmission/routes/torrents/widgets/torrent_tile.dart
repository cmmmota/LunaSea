import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/duration.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/transmission.dart';
import 'package:lunasea/modules/transmission/core/types.dart';

class TransmissionTorrentTile extends StatefulWidget {
  static final itemExtent = LunaBlock.calculateItemExtent(3);

  final TransmissionTorrent torrent;

  const TransmissionTorrentTile({
    Key? key,
    required this.torrent,
  }) : super(key: key);

  @override
  State<TransmissionTorrentTile> createState() => _State();
}

class _State extends State<TransmissionTorrentTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<TransmissionState, Future<Map<int?, TransmissionTorrent>>?>(
      selector: (_, state) => state.torrents,
      builder: (context, series, _) {
        return _buildBlockTile();
      },
    );
  }

  Widget _buildBlockTile() {
    return LunaBlock(
      posterPlaceholderIcon: widget.torrent.toIcon(),
      disabled: false,
      title: widget.torrent.name,
      body: [
        _subtitle1(),
        _subtitle2(),
      ],
      bottom: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(TransmissionUtilities.foregroundColor(widget.torrent)),
        backgroundColor: TransmissionUtilities.backgroundColor(widget.torrent, Theme.of(context).canvasColor),
        value: TransmissionUtilities.percentDone(widget.torrent),
      ),
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  TextSpan _buildChildTextSpan(String? text, TransmissionTorrentSorting sorting) {
    TextStyle? style;
    if (context.read<TransmissionState>().torrentSortType == sorting) {
      style = const TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: LunaUI.FONT_SIZE_H3,
      );
    }
    return TextSpan(
      text: text,
      style: style,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(text: '${widget.torrent.readableRateDownload()} down'),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: '${widget.torrent.readableRateUpload()} up'),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        _buildChildTextSpan(
          widget.torrent.status!.value,
          TransmissionTorrentSorting.STATUS,
        ),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(text: '${widget.torrent.readableDownloadedOrUploaded()}'),
        TextSpan(text: 'of'.pad()),
        TextSpan(text: '${widget.torrent.readableTotalSize()} '),
        TextSpan(text: ' (${TransmissionUtilities.readablePercentDone(widget.torrent)})'),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: '${'transmission.timeLeft'.tr()}: '),
        TextSpan(text: widget.torrent.eta!.toInt().asWordDuration()),
      ],
    );
  }

  Future<void> _onTap() async {
    // TransmissionRoutes.SERIES.go(params: {
    //   'series': widget.torrent.id!.toString(),
    // });
  }

  Future<void> _onLongPress() async {
    // Tuple2<bool, SonarrSeriesSettingsType?> values = await SonarrDialogs().seriesSettings(
    //   context,
    //   widget.torrent,
    // );
    // if (values.item1) values.item2!.execute(context, widget.torrent);
  }
}
