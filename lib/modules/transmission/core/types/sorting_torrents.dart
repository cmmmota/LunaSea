import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

part 'sorting_torrents.g.dart';

@HiveType(typeId: 30, adapterName: 'TransmissionTorrentSortingAdapter')
enum TransmissionTorrentSorting {
  @HiveField(0)
  ALPHABETICAL,
  @HiveField(1)
  DATE_ADDED,
  @HiveField(2)
  QUEUE,
  @HiveField(3)
  SIZE,
  @HiveField(4)
  STATUS
}

extension TransmissionTorrentSortingExtension on TransmissionTorrentSorting {
  String get key {
    switch (this) {
      case TransmissionTorrentSorting.ALPHABETICAL:
        return 'abc';
      case TransmissionTorrentSorting.DATE_ADDED:
        return 'date_added';
      case TransmissionTorrentSorting.SIZE:
        return 'size';
      case TransmissionTorrentSorting.QUEUE:
        return 'queue';
      case TransmissionTorrentSorting.STATUS:
        return 'status';
    }
  }

  String get readable {
    switch (this) {
      case TransmissionTorrentSorting.ALPHABETICAL:
        return 'Alphabetical';
      case TransmissionTorrentSorting.DATE_ADDED:
        return 'Date Added';
      case TransmissionTorrentSorting.SIZE:
        return 'Size';
      case TransmissionTorrentSorting.QUEUE:
        return 'Queue Posistion';
      case TransmissionTorrentSorting.STATUS:
        return 'Status';
    }
  }

  String value(TransmissionTorrent torrent) {
    switch (this) {
      case TransmissionTorrentSorting.ALPHABETICAL:
        return torrent.name!;
      case TransmissionTorrentSorting.DATE_ADDED:
        return torrent.eta!.toString();
      case TransmissionTorrentSorting.SIZE:
        return torrent.sizeWhenDone!.toString();
      case TransmissionTorrentSorting.QUEUE:
        return torrent.queuePosition.toString();
      case TransmissionTorrentSorting.STATUS:
        return torrent.status.toString();
    }
  }

  TransmissionTorrentSorting? fromKey(String? key) {
    switch (key) {
      case 'abc':
        return TransmissionTorrentSorting.ALPHABETICAL;
      case 'date_added':
        return TransmissionTorrentSorting.DATE_ADDED;
      case 'size':
        return TransmissionTorrentSorting.SIZE;
      case 'queue':
        return TransmissionTorrentSorting.QUEUE;
      case 'status':
        return TransmissionTorrentSorting.STATUS;
      default:
        return null;
    }
  }

  List<TransmissionTorrent> sort(List<TransmissionTorrent> data, bool ascending) => _Sorter().byType(data, this, ascending);
}

class _Sorter {
  List<TransmissionTorrent> byType(
    List<TransmissionTorrent> data,
    TransmissionTorrentSorting type,
    bool ascending,
  ) {
    switch (type) {
      case TransmissionTorrentSorting.DATE_ADDED:
        return _dateAdded(data, ascending);
      case TransmissionTorrentSorting.ALPHABETICAL:
        return _alphabetical(data, ascending);
      case TransmissionTorrentSorting.SIZE:
        return _size(data, ascending);
      case TransmissionTorrentSorting.QUEUE:
        return _queue(data, ascending);
      case TransmissionTorrentSorting.STATUS:
        return _status(data, ascending);
    }
  }

  List<TransmissionTorrent> _alphabetical(List<TransmissionTorrent> series, bool ascending) {
    ascending
        ? series.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()))
        : series.sort((a, b) => b.name!.toLowerCase().compareTo(a.name!.toLowerCase()));
    return series;
  }

  List<TransmissionTorrent> _dateAdded(List<TransmissionTorrent> series, bool ascending) {
    series.sort((a, b) {
      if (ascending) {
        if (a.addedDate == null) return 1;
        if (b.addedDate == null) return -1;
        int _comparison = a.addedDate!.compareTo(b.addedDate!);
        return _comparison == 0 ? a.name!.toLowerCase().compareTo(b.name!.toLowerCase()) : _comparison;
      } else {
        if (b.addedDate == null) return -1;
        if (a.addedDate == null) return 1;
        int _comparison = b.addedDate!.compareTo(a.addedDate!);
        return _comparison == 0 ? a.name!.toLowerCase().compareTo(b.name!.toLowerCase()) : _comparison;
      }
    });
    return series;
  }

  List<TransmissionTorrent> _size(List<TransmissionTorrent> series, bool ascending) {
    series.sort((a, b) {
      int _comparison = ascending ? (a.sizeWhenDone ?? 0).compareTo(b.sizeWhenDone ?? 0) : (b.sizeWhenDone ?? 0).compareTo(a.sizeWhenDone ?? 0);
      return _comparison == 0 ? a.name!.toLowerCase().compareTo(b.name!.toLowerCase()) : _comparison;
    });
    return series;
  }

  List<TransmissionTorrent> _queue(List<TransmissionTorrent> series, bool ascending) {
    series.sort((a, b) {
      int _comparison = ascending ? (a.queuePosition ?? 0).compareTo(b.queuePosition ?? 0) : (b.queuePosition ?? 0).compareTo(a.queuePosition ?? 0);
      return _comparison == 0 ? a.name!.toLowerCase().compareTo(b.name!.toLowerCase()) : _comparison;
    });
    return series;
  }

  List<TransmissionTorrent> _status(List<TransmissionTorrent> series, bool ascending) {
    series.sort((a, b) {
      int _comparison = ascending ? (a.sizeWhenDone ?? 0).compareTo(b.sizeWhenDone ?? 0) : (b.sizeWhenDone ?? 0).compareTo(a.sizeWhenDone ?? 0);
      return _comparison == 0 ? a.name!.toLowerCase().compareTo(b.name!.toLowerCase()) : _comparison;
    });
    return series;
  }
}
