part of transmission_commands;

Future<TransmissionTorrentList> _commandGetTorrents(
  Dio client,
) async {
  Response response = await client.post('', data: {
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
        "uploadRatio"
      ],
      "method": "torrent-get"
    }
  });
  return TransmissionTorrentList.fromJson(response.data);
}
