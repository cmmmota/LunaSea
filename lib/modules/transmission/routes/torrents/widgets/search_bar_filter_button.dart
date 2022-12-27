// import 'package:flutter/material.dart';
// import 'package:lunasea/core.dart';
// import 'package:lunasea/extensions/scroll_controller.dart';
// import 'package:lunasea/modules/transmission.dart';

// class TransmissionTorrentSearchBarFilterButton extends StatefulWidget {
//   final ScrollController controller;

//   const TransmissionTorrentSearchBarFilterButton({
//     Key? key,
//     required this.controller,
//   }) : super(key: key);

//   @override
//   State<TransmissionTorrentSearchBarFilterButton> createState() => _State();
// }

// class _State extends State<TransmissionTorrentSearchBarFilterButton> {
//   @override
//   Widget build(BuildContext context) => LunaCard(
//         context: context,
//         child: Consumer<TransmissionState>(
//           builder: (context, state, _) => LunaPopupMenuButton<SonarrSeriesFilter>(
//             tooltip: 'sonarr.FilterCatalogue'.tr(),
//             icon: Icons.filter_list_rounded,
//             onSelected: (result) {
//               state.seriesFilterType = result;
//               widget.controller.animateToStart();
//             },
//             itemBuilder: (context) => List<PopupMenuEntry<SonarrSeriesFilter>>.generate(
//               SonarrSeriesFilter.values.length,
//               (index) => PopupMenuItem<SonarrSeriesFilter>(
//                 value: SonarrSeriesFilter.values[index],
//                 child: Text(
//                   SonarrSeriesFilter.values[index].readable,
//                   style: TextStyle(
//                     fontSize: LunaUI.FONT_SIZE_H3,
//                     color: state.seriesFilterType == SonarrSeriesFilter.values[index] ? LunaColours.accent : Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         height: LunaTextInputBar.defaultHeight,
//         width: LunaTextInputBar.defaultHeight,
//         margin: const EdgeInsets.only(left: LunaUI.DEFAULT_MARGIN_SIZE),
//         color: Theme.of(context).canvasColor,
//       );
// }
