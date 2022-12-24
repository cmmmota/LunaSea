import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/transmission.dart';
import 'package:lunasea/router/routes/transmission.dart';

class TransmissionTorrentTile extends StatefulWidget {
  final TransmissionTorrentRecord torrent;

  const TransmissionTorrentTile({
    Key? key,
    required this.torrent,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TransmissionTorrentTile> {
  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: widget.torrent.name!,
      collapsedSubtitles: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
        _subtitle4(),
      ],
      expandedTableContent: _expandedTableContent(),
      expandedHighlightedNodes: _expandedHighlightedNodes(),
      expandedTableButtons: _tableButtons(),
      collapsedTrailing: _collapsedTrailing(),
      onLongPress: _onLongPress,
    );
  }

  Future<void> _onLongPress() async {
    // TransmissionRoutes.TORRENTS.go(params: {
    //   'torrent': widget.torrent.id!.toString(),
    // });
  }

  Widget _collapsedTrailing() {
    Tuple3<String, IconData, Color> _status = widget.torrent.lunaStatusParameters();
    return LunaIconButton(
      icon: _status.item2,
      color: _status.item3,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      text: widget.torrent.percentDone.toString() ?? LunaUI.TEXT_EMDASH,
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(text: widget.torrent.episode?.lunaSeasonEpisode() ?? LunaUI.TEXT_EMDASH),
        const TextSpan(text: ': '),
        TextSpan(text: widget.torrent.episode!.title ?? LunaUI.TEXT_EMDASH, style: const TextStyle(fontStyle: FontStyle.italic)),
      ],
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      children: [
        TextSpan(
          text: widget.queuetorrentRecord.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        if (widget.torrent.language != null)
          TextSpan(
            text: widget.torrent.language?.name ?? LunaUI.TEXT_EMDASH,
          ),
        if (widget.torrent.language != null) TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(
          text: widget.torrent.lunaTimeLeft(),
        ),
      ],
    );
  }

  TextSpan _subtitle4() {
    Tuple3<String, IconData, Color> _params = widget.torrent.lunaStatusParameters(canBeWhite: false);
    return TextSpan(
      style: TextStyle(
        color: _params.item3,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      children: [
        TextSpan(text: widget.torrent.lunaPercentage()),
        TextSpan(text: LunaUI.TEXT_EMDASH.pad()),
        TextSpan(text: _params.item1),
      ],
    );
  }

  List<LunaHighlightedNode> _expandedHighlightedNodes() {
    Tuple3<String, IconData, Color> _status = widget.torrent.lunaStatusParameters(canBeWhite: false);
    return [
      LunaHighlightedNode(
        text: widget.torrent.protocol!.lunaReadable(),
        backgroundColor: widget.torrent.protocol!.lunaProtocolColor(),
      ),
      LunaHighlightedNode(
        text: widget.torrent.lunaPercentage(),
        backgroundColor: _status.item3,
      ),
      LunaHighlightedNode(
        text: widget.torrent.status!.lunaStatus(),
        backgroundColor: _status.item3,
      ),
    ];
  }

  List<LunaTableContent> _expandedTableContent() {
    return [
      LunaTableContent(
        title: 'sonarr.Series'.tr(),
        body: widget.torrent.series?.title ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'sonarr.Episode'.tr(),
        body: widget.torrent.episode?.lunaSeasonEpisode() ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'sonarr.Title'.tr(),
        body: widget.torrent.episode?.title ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(title: '', body: ''),
      LunaTableContent(
        title: 'sonarr.Quality'.tr(),
        body: widget.torrent.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'sonarr.Client'.tr(),
        body: widget.torrent.downloadClient ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'sonarr.Size'.tr(),
        body: widget.torrent.size?.floor().asBytes() ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'sonarr.TimeLeft'.tr(),
        body: widget.torrent.lunaTimeLeft(),
      ),
    ];
  }

  List<LunaButton> _tableButtons() {
    return [
      if ((widget.queueRecord.statusMessages ?? []).isNotEmpty)
        LunaButton.text(
          icon: Icons.messenger_outline_rounded,
          color: LunaColours.orange,
          text: 'sonarr.Messages'.tr(),
          onTap: () async {
            SonarrDialogs().showQueueStatusMessages(
              context,
              widget.queueRecord.statusMessages!,
            );
          },
        ),
      // if (widget.queueRecord.status == SonarrQueueStatus.COMPLETED &&
      //     widget.queueRecord?.trackedDownloadStatus ==
      //         SonarrTrackedDownloadStatus.WARNING)
      //   LunaButton.text(
      //     icon: Icons.download_done_rounded,
      //     text: 'sonarr.Import'.tr(),
      //     onTap: () async {},
      //   ),
      LunaButton.text(
        icon: Icons.delete_rounded,
        color: LunaColours.red,
        text: 'lunasea.Remove'.tr(),
        onTap: () async {
          bool result = await SonarrDialogs().removeFromQueue(context);
          if (result) {
            SonarrAPIController()
                .removeFromQueue(
              context: context,
              torrent: widget.queueRecord,
            )
                .then((_) {
              switch (widget.type) {
                case SonarrQueueTileType.ALL:
                  context.read<SonarrQueueState>().fetchQueue(
                        context,
                        hardCheck: true,
                      );
                  break;
                case SonarrQueueTileType.EPISODE:
                  context.read<SonarrSeasonDetailsState>().fetchState(
                        context,
                        shouldFetchEpisodes: false,
                        shouldFetchFiles: false,
                      );
                  break;
              }
            });
          }
        },
      ),
    ];
  }
}
