import 'package:lunasea/modules/transmission/core/types.dart';
import 'package:lunasea/types/list_view_option.dart';
import 'package:lunasea/database/table.dart';
import 'package:lunasea/modules/transmission/core/types/filter_torrents.dart';

enum TransmissionDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0),
  DEFAULT_SORTING_TORRENTS_ASCENDING<bool>(true),
  DEFAULT_SORTING_TORRENTS<TransmissionTorrentSorting>(TransmissionTorrentSorting.QUEUE),
  // NAVIGATION_INDEX_SERIES_DETAILS<int>(0),
  // NAVIGATION_INDEX_SEASON_DETAILS<int>(0),
  // ADD_SERIES_SEARCH_FOR_MISSING<bool>(false),
  // ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET<bool>(false),
  // ADD_SERIES_DEFAULT_MONITORED<bool>(true),
  // ADD_SERIES_DEFAULT_ROOT_FOLDER<int?>(null),
  // ADD_SERIES_DEFAULT_TAGS<List>([]),
  // DEFAULT_VIEW_SERIES<LunaListViewOption>(LunaListViewOption.BLOCK_VIEW),
  // DEFAULT_SORTING_RELEASES_ASCENDING<bool>(true),
  // REMOVE_SERIES_DELETE_FILES<bool>(false),
  // QUEUE_PAGE_SIZE<int>(50),
  TORRENT_REFRESH_RATE<int>(5);
  // QUEUE_REMOVE_DOWNLOAD_CLIENT<bool>(false),
  // CONTENT_PAGE_SIZE<int>(10);

  @override
  LunaTable get table => LunaTable.transmission;

  @override
  final T fallback;

  const TransmissionDatabase(this.fallback);

  @override
  void register() {
    // Hive.registerAdapter(SonarrMonitorStatusAdapter());
    // Hive.registerAdapter(SonarrSeriesSortingAdapter());
    // Hive.registerAdapter(SonarrSeriesFilterAdapter());
    // Hive.registerAdapter(SonarrReleasesSortingAdapter());
    // Hive.registerAdapter(SonarrReleasesFilterAdapter());
  }

  @override
  dynamic export() {
    TransmissionDatabase db = this;
    switch (db) {
      case TransmissionDatabase.NAVIGATION_INDEX:
        return TransmissionDatabase.NAVIGATION_INDEX.read();
      default:
        return super.export();
    }
  }

  @override
  void import(dynamic value) {
    TransmissionDatabase db = this;
    dynamic result;

    switch (db) {
      case TransmissionDatabase.NAVIGATION_INDEX:
        result = LunaListViewOption.fromKey(value.toString());
        break;
      default:
        result = value;
        break;
    }

    return super.import(result);
  }
}
