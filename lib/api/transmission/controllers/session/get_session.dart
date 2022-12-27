part of transmission_commands;

Future<TransmissionSession> _commandGetSession(
  Dio client,
) async {
  var requestData = {
    "arguments": {
      "fields": [
        "version",
      ],
    },
    "method": "session-get"
  };

  var result = await _request(client, requestData);

  return TransmissionSession.fromJson(result);
}

Future<dynamic> _request(Dio client, dynamic requestData) async {
  bool breakRequest = false;
  var errorCount = 0;

  while (!breakRequest) {
    try {
      var response = await client.post('', data: requestData);

      return response.data;
    } on DioError catch (e) {
      if (e.response?.statusCode != 409 || errorCount > 0) {
        rethrow;
      }

      errorCount++;

      _ensureSessionId(client, e.response);
    }
  }
}

Future<void> _ensureSessionId(Dio client, Response? response) async {
  _sessionId = response?.headers.value('X-Transmission-Session-Id')!;

  if (_sessionId?.isNotEmpty == true) {
    _setSessionId(client, _sessionId);
  }
}

void _setSessionId(Dio client, String? sessionId) {
  client.options.headers['X-Transmission-Session-Id'] = _sessionId;
}
