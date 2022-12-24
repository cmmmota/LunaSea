import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/transmission.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum TransmissionRoutes with LunaRoutesMixin {
  HOME('/transmission');

  @override
  final String path;

  const TransmissionRoutes(this.path);

  @override
  LunaModule get module => LunaModule.TRANSMISSION;

  @override
  bool isModuleEnabled(BuildContext context) {
    return context.read<TransmissionState>().enabled;
  }

  @override
  GoRoute get routes {
    switch (this) {
      case TransmissionRoutes.HOME:
        return route(widget: const TransmissionRoute());
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case TransmissionRoutes.HOME:
        return [];
      default:
        return const [];
    }
  }
}
