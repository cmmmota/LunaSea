part of transmission_commands;

/// Facilitates, encapsulates, and manages individual commands within transmission.
///
/// [TransmissionControllerCommands] internally handles routing the HTTP client to the API calls.
class TransmissionControllerCommands {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  TransmissionControllerCommands(this._client);

  /// Handler for [torrent-start](https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md#31-torrent-action-requests).
  ///
  /// Resumes a list of torrents.
  Future<void> resumeTorrents(List<int> ids) async => _commandResumeTorrents(_client, ids);

  /// Handler for [torrent-stop](https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md#31-torrent-action-requests).
  ///
  /// Resumes a list of torrents.
  Future<void> pauseTorrents(List<int> ids) async => _commandPauseTorrents(_client, ids);

  /// Handler for [torrent-start](https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md#31-torrent-action-requests).
  ///
  /// Resumes all available torrents.
  Future<void> resumeAllTorrents() async => _commandResumeAllTorrents(_client);

  /// Handler for [torrent-stop](https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md#31-torrent-action-requests).
  ///
  /// Resumes all available torrents.
  Future<void> pauseAllTorrents() async => _commandPauseAllTorrents(_client);
}
