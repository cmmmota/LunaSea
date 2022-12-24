part of transmission_commands;

/// Facilitates, encapsulates, and manages individual calls related to torrents within transmission.
///
/// [TransmissionControllerTorrents] internally handles routing the HTTP client to the API calls.
class TransmissionControllerTorrents {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  TransmissionControllerTorrents(this._client);

  /// Handler for [torrent-get](https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md#33-torrent-accessor-torrent-get).
  ///
  /// Gets currently downloading (queue) information.
  Future<TransmissionTorrentList> get() async => _commandGetTorrents(
        _client,
      );
}
