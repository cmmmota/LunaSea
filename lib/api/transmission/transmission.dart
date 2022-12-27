library transmission;

import 'package:lunasea/api/transmission/controllers.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class TransmissionAPI {
  TransmissionAPI._internal({
    required this.httpClient,
    required this.command,
    required this.torrent,
    required this.session,
  });

  factory TransmissionAPI({
    required String host,
    required String username,
    required String password,
    Map<String, dynamic>? headers,
    bool followRedirects = true,
    int maxRedirects = 5,
  }) {
    headers ??= <String, dynamic>{};

    var credential = utf8.fuse(base64).encode('$username:$password');
    var basicAuth = 'Basic $credential';

    headers['authorization'] = basicAuth;

    Dio _dio = Dio(
      BaseOptions(
        baseUrl: host.endsWith('/') ? '${host}transmission/rpc' : '$host/transmission/rpc/',
        queryParameters: {},
        headers: headers,
        followRedirects: followRedirects,
        maxRedirects: maxRedirects,
      ),
    );

    return TransmissionAPI._internal(
      httpClient: _dio,
      command: TransmissionControllerCommand(_dio),
      torrent: TransmissionControllerTorrents(_dio),
      session: TransmissionControllerSession(_dio),
    );
  }

  factory TransmissionAPI.from({
    required Dio client,
  }) {
    return TransmissionAPI._internal(
      httpClient: client,
      command: TransmissionControllerCommand(client),
      torrent: TransmissionControllerTorrents(client),
      session: TransmissionControllerSession(client),
    );
  }

  final Dio httpClient;

  final TransmissionControllerCommand command;
  final TransmissionControllerTorrents torrent;
  final TransmissionControllerSession session;
}
