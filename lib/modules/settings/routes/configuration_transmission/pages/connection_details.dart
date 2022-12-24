import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/transmission.dart';
import 'package:lunasea/modules/transmission/core/state.dart';

class ConfigurationTransmissionConnectionDetailsRoute extends StatefulWidget {
  const ConfigurationTransmissionConnectionDetailsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationTransmissionConnectionDetailsRoute> createState() => _State();
}

class _State extends State<ConfigurationTransmissionConnectionDetailsRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'Connection Details',
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        _testConnection(),
      ],
    );
  }

  Widget _body() {
    return LunaBox.profiles.listenableBuilder(
      builder: (context, _) => LunaListView(
        controller: scrollController,
        children: [
          _host(),
          _userName(),
          _password()
          //_customHeaders(),
        ],
      ),
    );
  }

  Widget _host() {
    String host = LunaProfile.current.transmissionHost;
    return LunaBlock(
      title: 'settings.Host'.tr(),
      body: [TextSpan(text: host.isEmpty ? 'lunasea.NotSet'.tr() : host)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: host,
        );
        if (_values.item1) {
          LunaProfile.current.transmissionHost = _values.item2;
          LunaProfile.current.save();
          context.read<TransmissionState>().reset();
        }
      },
    );
  }

  Widget _userName() {
    String userName = LunaProfile.current.transmissionUsername;
    return LunaBlock(
      title: 'settings.UserName'.tr(),
      body: [
        TextSpan(
          text: userName.isEmpty ? 'lunasea.NotSet'.tr() : userName,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
          context,
          'settings.UserName'.tr(),
          prefill: userName,
        );
        if (_values.item1) {
          LunaProfile.current.transmissionUsername = _values.item2;
          LunaProfile.current.save();
          context.read<TransmissionState>().reset();
        }
      },
    );
  }

  Widget _password() {
    String password = LunaProfile.current.transmissionUsername;
    return LunaBlock(
      title: 'settings.Password'.tr(),
      body: [
        TextSpan(
          text: password.isEmpty ? 'lunasea.NotSet'.tr() : LunaUI.TEXT_OBFUSCATED_PASSWORD,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
          context,
          'settings.Password'.tr(),
          prefill: password,
        );
        if (_values.item1) {
          LunaProfile.current.transmissionPassword = _values.item2;
          LunaProfile.current.save();
          context.read<TransmissionState>().reset();
        }
      },
    );
  }

  Widget _testConnection() {
    return LunaButton.text(
      text: 'settings.TestConnection'.tr(),
      icon: LunaIcons.CONNECTION_TEST,
      onTap: () async {
        LunaProfile _profile = LunaProfile.current;
        if (_profile.transmissionHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'Host Required',
            message: 'Host is required to connect to Transmission',
          );
          return;
        }

        TransmissionAPI(
          host: _profile.transmissionHost,
          username: _profile.transmissionUsername,
          password: _profile.transmissionPassword,
          // headers: Map<String, dynamic>.from(
          //   _profile.tranmi,
          // ),
        ).session.getStatus().then((_) {
          showLunaSuccessSnackBar(
            title: 'Connected Successfully',
            message: 'Transmission is ready to use with LunaSea',
          );
        }).catchError((error, trace) {
          LunaLogger().error(
            'Connection Test Failed',
            error,
            trace,
          );
          showLunaErrorSnackBar(
            title: 'Connection Test Failed',
            error: error,
          );
        });
      },
    );
  }

  // Widget _customHeaders() {
  //   return LunaBlock(
  //     title: 'settings.CustomHeaders'.tr(),
  //     body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
  //     trailing: const LunaIconButton.arrow(),
  //     onTap: SettingsRoutes.CONFIGURATION_TRANSMISSION_CONNECTION_DETAILS_HEADERS.go,
  //   );
  // }
}
