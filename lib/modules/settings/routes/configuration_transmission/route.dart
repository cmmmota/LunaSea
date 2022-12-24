import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission/core/state.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationTransmissionRoute extends StatefulWidget {
  const ConfigurationTransmissionRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationTransmissionRoute> createState() => _State();
}

class _State extends State<ConfigurationTransmissionRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Transmission',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [LunaModule.TRANSMISSION.informationBanner(), _enabledToggle(), _connectionDetailsPage(), LunaDivider()],
    );
  }

  Widget _enabledToggle() {
    return LunaBox.profiles.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'Enable ${LunaModule.TRANSMISSION.title}',
        trailing: LunaSwitch(
          value: LunaProfile.current.transmissionEnabled,
          onChanged: (value) {
            LunaProfile.current.transmissionEnabled = value;
            LunaProfile.current.save();
            context.read<TransmissionState>().reset();
          },
        ),
      ),
    );
  }

  Widget _connectionDetailsPage() {
    return LunaBlock(
      title: 'settings.ConnectionDetails'.tr(),
      body: [
        TextSpan(
          text: 'settings.ConnectionDetailsDescription'.tr(
            args: [LunaModule.TRANSMISSION.title],
          ),
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_TRANSMISSION_CONNECTION_DETAILS.go,
    );
  }
}
