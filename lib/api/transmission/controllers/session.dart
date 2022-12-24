part of transmission_commands;

/// Facilitates, encapsulates, and manages individual calls related to system within transmission.
///
/// [TransmissionControllerSystem] internally handles routing the HTTP client to the API calls.
class TransmissionControllerSession {
  final Dio _client;

  /// Create a system command handler using an initialized [Dio] client.
  TransmissionControllerSession(this._client);

  /// Handler for [session](https://github.com/transmission/transmission/blob/main/docs/rpc-spec.md#412-accessors).
  ///
  /// Returns session status information.
  Future<TransmissionSession> getStatus() async => _commandGetSession(_client);
}
