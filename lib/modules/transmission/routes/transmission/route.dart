import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

import 'widgets.dart';

class TransmissionRoute extends StatefulWidget {
  const TransmissionRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<TransmissionRoute> createState() => _State();
}

class _State extends State<TransmissionRoute> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaPageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
      initialPage: TransmissionDatabase.NAVIGATION_INDEX.read(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.TRANSMISSION,
      drawer: _drawer(),
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  Widget _drawer() {
    return LunaDrawer(page: LunaModule.TRANSMISSION.key);
  }

  Widget? _bottomNavigationBar() {
    if (context.read<TransmissionState>().enabled) {
      return TransmissionNavigationBar(pageController: _pageController);
    }
    return null;
  }

  PreferredSizeWidget _appBar() {
    List<String> profiles = LunaBox.profiles.keys.fold(
      [],
      (value, element) {
        if (LunaBox.profiles.read(element)?.transmissionEnabled ?? false) {
          value.add(element);
        }
        return value;
      },
    );
    List<Widget>? actions;
    if (context.watch<TransmissionState>().enabled) {
      actions = [
        // const TransmissionAppBarAddTorrentAction(),
        const TransmissionAppBarGlobalSettingsAction(),
      ];
    }
    return LunaAppBar.dropdown(
      title: LunaModule.TRANSMISSION.title,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: TransmissionNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    return Selector<TransmissionState, bool?>(
      selector: (_, state) => state.enabled,
      builder: (context, enabled, _) {
        if (!enabled!) {
          return LunaMessage.moduleNotEnabled(
            context: context,
            module: 'Transmission',
          );
        }
        return LunaPageView(
          controller: _pageController,
          children: const [
            TransmissionTorrentsRoute(),
          ],
        );
      },
    );
  }
}
