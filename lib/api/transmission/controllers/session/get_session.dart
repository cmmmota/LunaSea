part of transmission_commands;

Future<TransmissionSession> _commandGetSession(
  Dio client,
) async {
  Response response = await client.post('', data: {
    "arguments": {
      "fields": [
        "version",
      ],
      "method": "tsession-get"
    }
  });
  return TransmissionSession.fromJson(response.data);
}
