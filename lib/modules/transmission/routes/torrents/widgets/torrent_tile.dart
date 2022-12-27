import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
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
      //backgroundHeaders: context.read<TransmissionState>().headers,
      //posterHeaders: context.read<TransmissionState>().headers,
      posterPlaceholderIcon: widget.torrent.toIcon(),
      disabled: false,
      title: widget.torrent.name,
      body: [
        _subtitle1(),
        _subtitle2(),
        //_subtitle3(),
      ],
      bottom: LinearProgressIndicator(color: LunaColours.accent, value: widget.torrent.percentDone),
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
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        _buildChildTextSpan(
          widget.torrent.status!.value,
          TransmissionTorrentSorting.STATUS,
        ),
      ],
    );
  }

  TextSpan _subtitle3() {
    TransmissionTorrentSorting _sorting = context.read<TransmissionState>().torrentSortType;
    return TextSpan(
      children: [
        if (_sorting == TransmissionTorrentSorting.DATE_ADDED)
          _buildChildTextSpan(
            widget.torrent.addedDate.toString(),
            TransmissionTorrentSorting.DATE_ADDED,
          ),
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
