import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';
import 'package:lunasea/modules/transmission/core/types.dart';
import 'package:lunasea/modules/transmission/routes/torrents/widgets/statistics_bar.dart';
import 'package:lunasea/modules/transmission/routes/torrents/widgets/torrent_top_bar.dart';
import 'package:lunasea/modules/transmission/routes/transmission/widgets.dart';
import 'package:lunasea/router/routes/transmission.dart';

class TransmissionTorrentsRoute extends StatefulWidget {
  const TransmissionTorrentsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<TransmissionTorrentsRoute> createState() => _State();
}

class _State extends State<TransmissionTorrentsRoute> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

  late TransmissionState _state = context.read<TransmissionState>();

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _refresh() async => setState(() {
        _fetch();
      });

  Future<void> _fetchWithoutMessage() async {
    _fetch().then((_) => {if (mounted) setState(() {})});
  }

  Future _fetch() async {
    _state.fetchAllTorrents();
    _state.fetchStatistics();

    return Future.wait([_state.torrents!, _state.statistics!]).then((data) {
      try {
        if (_timer == null || !_timer!.isActive) _createTimer();
        return true;
      } catch (error) {
        return Future.error(error);
      }
    }).catchError((error) {
      return Future.error(error);
    });
  }

  void _createTimer() => _timer = Timer(const Duration(seconds: 5), _fetchWithoutMessage);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.TRANSMISSION,
      body: _body(),
      appBar: _appBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar.empty(
      child: TransmissionTorrentSearchBar(
        scrollController: TransmissionNavigationBar.scrollControllers[0],
      ),
      height: LunaTextInputBar.defaultAppBarHeight,
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: _refresh,
      child: Selector<TransmissionState, Tuple2<Future<Map<int?, TransmissionTorrent>>?, Future<TransmissionSessionStatistics>?>>(
        selector: (_, state) => Tuple2(
          state.torrents,
          state.statistics,
        ),
        builder: (context, tuple, _) => FutureBuilder(
          future: Future.wait([
            tuple.item1!,
            tuple.item2!,
          ]),
          builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                  'Unable to fetch Transmission torrents',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              }
              return LunaMessage.error(
                onTap: _refreshKey.currentState!.show,
              );
            }
            if (snapshot.hasData) {
              return LunaListView(
                controller: TransmissionNavigationBar.scrollControllers[0],
                children: [
                  TransmissionTorrentTopBar(statistics: snapshot.data![1] as TransmissionSessionStatistics),
                  _torrents(snapshot.data![0] as Map<int, TransmissionTorrent>)
                ],
              );
            }
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  List<TransmissionTorrent> _filterAndSort(
    Map<int, TransmissionTorrent> torrents,
    String query,
  ) {
    if (torrents.isEmpty) return [];
    TransmissionTorrentSorting sorting = context.watch<TransmissionState>().torrentSortType;
    bool ascending = context.watch<TransmissionState>().torrentsSortAscending;
    // Filter
    List<TransmissionTorrent> filtered = torrents.values.where((show) {
      if (query.isNotEmpty && show.id != null) return show.name!.toLowerCase().contains(query.toLowerCase());
      return show.id != null;
    }).toList();
    // Sort
    filtered = sorting.sort(filtered, ascending);
    return filtered;
  }

  Widget _torrents(
    Map<int, TransmissionTorrent> torrents,
  ) {
    if (torrents.isEmpty) {
      return Row(children: [
        LunaMessage(
          text: 'transmission.NoTorrentsFound'.tr(),
          buttonText: 'transmission.Refresh'.tr(),
          onTap: _refreshKey.currentState!.show,
        )
      ]);
    }

    return Selector<TransmissionState, String>(
      selector: (_, state) => state.torrentSearchQuery,
      builder: (context, query, _) {
        List<TransmissionTorrent> _filtered = _filterAndSort(torrents, query);
        if (_filtered.isEmpty)
          return LunaListView(
            controller: TransmissionNavigationBar.scrollControllers[0],
            children: [
              LunaMessage.inList(text: 'transmission.NoTorrentsFound'.tr()),
              if (query.isNotEmpty)
                LunaButtonContainer(
                  children: [
                    LunaButton.text(
                      icon: null,
                      text: query.length > 20
                          ? 'transmission.SearchFor'.tr(args: ['"${query.substring(0, min(20, query.length))}${LunaUI.TEXT_ELLIPSIS}"'])
                          : 'transmission.SearchFor'.tr(args: ['"$query"']),
                      backgroundColor: LunaColours.accent,
                      onTap: () async {
                        // TransmissionRoutes.ADD_TORRENTS.go(queryParams: {
                        //   'query': query,
                        // });
                      },
                    ),
                  ],
                ),
            ],
          );
        return _blockView(_filtered);
      },
    );
  }

  Widget _blockView(List<TransmissionTorrent> torrents) {
    return LunaListViewBuilder(
      controller: TransmissionNavigationBar.scrollControllers[0],
      itemCount: torrents.length,
      itemExtent: TransmissionTorrentTile.itemExtent,
      itemBuilder: (context, index) => TransmissionTorrentTile(
        torrent: torrents[index],
        state: _state,
      ),
    );
  }
}
