part of transmission_commands;

String? _sessionId = '';

Future<TransmissionTorrentList> _commandGetTorrents(
  Dio client,
) async {
  var requestData = {
    "arguments": {
      "fields": [
        "queuePosition",
        "id",
        "name",
        "status",
        "isFinished",
        "eta",
        "etaIdle",
        "error",
        "errorString",
        "metadataPercentComplete",
        "maxConnectedPeers",
        "peersConnected",
        "peersSendingToUs",
        "percentComplete",
        "percentDone",
        "rateDownload",
        "rateUpload",
        "totalSize",
        "sizeWhenDone",
        "uploadRatio",
        "addedDate"
      ],
    },
    "method": "torrent-get"
  };

  var response = await _request(client, requestData);

  return TransmissionTorrentList.fromJson(response);
}
