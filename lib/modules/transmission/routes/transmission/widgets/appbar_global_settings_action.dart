import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/transmission.dart';

class TransmissionAppBarGlobalSettingsAction extends StatelessWidget {
  const TransmissionAppBarGlobalSettingsAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.more_vert_rounded,
      onPressed: () async {
        // Tuple2<bool, TransmissionGlobalSettingsType?> values = await TransmissionDialogs().globalSettings(context);
        // if (values.item1) values.item2!.execute(context);
      },
    );
  }
}
