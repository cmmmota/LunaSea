import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

import 'types.dart';

class TransmissionState extends LunaModuleState {
  TransmissionState() {
    reset();
  }

  @override
  void reset() {
    _torrents = null;

    resetProfile();
    if (_enabled) {
      fetchAllTorrents();
    }
    notifyListeners();
  }

  ///////////////
  /// PROFILE ///
  ///////////////

  /// API handler instance
  TransmissionAPI? _api;
  TransmissionAPI? get api => _api;

  /// Is the API enabled?
  bool _enabled = false;
  bool get enabled => _enabled;

  /// Transmission host
  String _host = '';
  String get host => _host;

  /// Transmission Username
  String _password = '';
  String get password => _password;

  /// Transmission Password
  String _username = '';
  String get username => _username;

  /// Headers to attach to all requests
  Map<dynamic, dynamic> _headers = {};
  Map<dynamic, dynamic> get headers => _headers;

  /// Reset the profile data, reinitializes API instance
  void resetProfile() {
    LunaProfile _profile = LunaProfile.current;
    // Copy profile into state
    _api = null;
    _enabled = _profile.transmissionEnabled;
    _host = _profile.transmissionHost;
    _username = _profile.transmissionUsername;
    _password = _profile.transmissionPassword;
    //_headers = null;
    // Create the API instance if Transmission is enabled
    if (_enabled) {
      _api = TransmissionAPI(
        host: _host,
        username: _username,
        password: _password,
        headers: Map<String, dynamic>.from(_headers),
      );
    }
  }

  /////////////////
  /// CATALOGUE ///
  /////////////////

  String _torrentSearchQuery = '';
  String get torrentSearchQuery => _torrentSearchQuery;
  set torrentSearchQuery(String seriesSearchQuery) {
    _torrentSearchQuery = seriesSearchQuery;
    notifyListeners();
  }

  TransmissionTorrentSorting _torrentSortType = TransmissionDatabase.DEFAULT_SORTING_TORRENTS.read();
  TransmissionTorrentSorting get torrentSortType => _torrentSortType;
  set torrentSortType(TransmissionTorrentSorting torrentSortType) {
    _torrentSortType = torrentSortType;
    notifyListeners();
  }

  bool _torrentsSortAscending = TransmissionDatabase.DEFAULT_SORTING_TORRENTS_ASCENDING.read();
  bool get torrentsSortAscending => _torrentsSortAscending;
  set torrentsSortAscending(bool torrentsSortAscending) {
    _torrentsSortAscending = torrentsSortAscending;
    notifyListeners();
  }

  //////////////
  /// SERIES ///
  //////////////

  Future<Map<int, TransmissionTorrent>>? _torrents;
  Future<Map<int, TransmissionTorrent>>? get torrents => _torrents;
  void fetchAllTorrents() {
    if (_api != null) {
      _torrents = _api!.torrent.get().then((torrents) {
        return {
          for (TransmissionTorrent s in torrents.arguments!.torrents!) s.id!: s,
        };
      });
    }
    notifyListeners();
  }

  Future<void> fetchTorrent(int torrentId) async {
    // if (_api != null) {
    //   TransmissionTorrentList torrents = await _api!.torrent.get(id: torrentId);
    //   (await _torrents)![torrentId] = torrent;
    // }
    // notifyListeners();
  }

  Future<void> removeSingleTorrent(int torrentId) async {
    (await _torrents)!.remove(torrentId);
    notifyListeners();
  }
}
