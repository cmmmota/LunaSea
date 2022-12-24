import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

class SonarrAPIController {
  Future<bool> removeTorrent({
    required BuildContext context,
    required TransmissionTorrentRecord torrent,
    bool showSnackbar = true,
  }) async {
    if (context.read<TransmissionState>().enabled) {
      // return await context
      //     .read<TransmissionState>()
      //     .api!
      //     .torrent
      //     .delete(
      //       seriesId: torrent.id!,
      //       deleteFiles: SonarrDatabase.REMOVE_SERIES_DELETE_FILES.read(),
      //       addImportListExclusion: SonarrDatabase.REMOVE_SERIES_EXCLUSION_LIST.read(),
      //     )
      //     .then((_) async {
      //   return await context.read<SonarrState>().removeSingleSeries(torrent.id!).then((_) {
      //     if (showSnackbar)
      //       showLunaSuccessSnackBar(
      //         title: SonarrDatabase.REMOVE_SERIES_DELETE_FILES.read() ? 'sonarr.RemovedSeriesWithFiles'.tr() : 'sonarr.RemovedSeries'.tr(),
      //         message: torrent.title,
      //       );
      //     return true;
      //   });
      // }).catchError((error, stack) {
      //   LunaLogger().error(
      //     'Failed to remove series: ${torrent.id}',
      //     error,
      //     stack,
      //   );
      //   if (showSnackbar)
      //     showLunaErrorSnackBar(
      //       title: 'sonarr.FailedToRemoveSeries'.tr(),
      //       error: error,
      //     );
      //   return false;
      // });
    }
    return false;
  }

  Future<TransmissionTorrentRecord?> addTorrent({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<TransmissionState>().enabled) {
      //   return await context.read<TransmissionState>().api!.torrent.add().then((series) {
      //     if (showSnackbar) {
      //       showLunaSuccessSnackBar(
      //         title: 'sonarr.AddedSeries'.tr(),
      //         message: series.title,
      //       );
      //     }
      //     return series;
      //   }).catchError((error, stack) {
      //     LunaLogger().error(
      //       'Failed to add series (tmdbId: ${series.tvdbId})',
      //       error,
      //       stack,
      //     );
      //     if (showSnackbar) {
      //       showLunaErrorSnackBar(
      //         title: 'sonarr.FailedToAddSeries'.tr(),
      //         error: error,
      //       );
      //     }
      //   });
    }
    return null;
  }
}
