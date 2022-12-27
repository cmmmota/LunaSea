import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/transmission.dart';
import 'package:lunasea/modules/transmission/core/types.dart';

class ConfigurationTransmissionDefaultOptionsRoute extends StatefulWidget {
  const ConfigurationTransmissionDefaultOptionsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationTransmissionDefaultOptionsRoute> createState() => _State();
}

class _State extends State<ConfigurationTransmissionDefaultOptionsRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.DefaultOptions'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaHeader(text: 'transmission.Torrents'.tr()),
        _sortingTorrents(),
        _sortingTorrentsDirection(),
      ],
    );
  }

  Widget _sortingTorrents() {
    const _db = TransmissionDatabase.DEFAULT_SORTING_TORRENTS;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.SortCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String?> titles = TransmissionTorrentSorting.values.map<String?>((sorting) => sorting.readable).toList();
          List<IconData> icons = List.filled(titles.length, LunaIcons.SORT);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.SortCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(TransmissionTorrentSorting.values[values.item2]);
            context.read<TransmissionState>().torrentSortType = _db.read();
            context.read<TransmissionState>().torrentsSortAscending = TransmissionDatabase.DEFAULT_SORTING_TORRENTS_ASCENDING.read();
          }
        },
      ),
    );
  }

  Widget _sortingTorrentsDirection() {
    const _db = TransmissionDatabase.DEFAULT_SORTING_TORRENTS_ASCENDING;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.SortDirection'.tr(),
        body: [
          TextSpan(
            text: _db.read() ? 'lunasea.Ascending'.tr() : 'lunasea.Descending'.tr(),
          ),
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }
}
