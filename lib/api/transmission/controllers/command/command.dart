part of transmission_commands;

Future<void> _commandResumeTorrents(
  Dio client,
  List<int> ids,
) async {
  var requestData = {
    "arguments": {"ids": ids},
    "method": "torrent-start"
  };

  await _request(client, requestData);
}

Future<void> _commandResumeAllTorrents(Dio client) async {
  var requestData = {"method": "torrent-start"};

  await _request(client, requestData);
}

Future<void> _commandPauseTorrents(
  Dio client,
  List<int> ids,
) async {
  var requestData = {
    "arguments": {"ids": ids},
    "method": "torrent-stop"
  };

  await _request(client, requestData);
}

Future<void> _commandPauseAllTorrents(Dio client) async {
  var requestData = {"method": "torrent-stop"};

  await _request(client, requestData);
}
