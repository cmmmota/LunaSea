// import 'package:flutter/material.dart';
// import 'package:lunasea/core.dart';
// import 'package:lunasea/extensions/scroll_controller.dart';
// import 'package:lunasea/modules/transmission.dart';
// import 'package:lunasea/types/list_view_option.dart';

// class TransmissionTorrentSearchBarViewButton extends StatefulWidget {
//   final ScrollController controller;

//   const TransmissionTorrentSearchBarViewButton({
//     Key? key,
//     required this.controller,
//   }) : super(key: key);

//   @override
//   State<TransmissionTorrentSearchBarViewButton> createState() => _State();
// }

// class _State extends State<TransmissionTorrentSearchBarViewButton> {
//   @override
//   Widget build(BuildContext context) {
//     return LunaCard(
//       context: context,
//       child: Consumer<TransmissionState>(
//         builder: (context, state, _) => LunaPopupMenuButton<LunaListViewOption>(
//           tooltip: 'lunasea.View'.tr(),
//           icon: LunaIcons.VIEW,
//           onSelected: (result) {
//             state.seriesViewType = result;
//             widget.controller.animateToStart();
//           },
//           itemBuilder: (context) => List<PopupMenuEntry<LunaListViewOption>>.generate(
//             LunaListViewOption.values.length,
//             (index) => PopupMenuItem<LunaListViewOption>(
//               value: LunaListViewOption.values[index],
//               child: Text(
//                 LunaListViewOption.values[index].readable,
//                 style: TextStyle(
//                   fontSize: LunaUI.FONT_SIZE_H3,
//                   color: state.seriesViewType == LunaListViewOption.values[index] ? LunaColours.accent : Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       margin: const EdgeInsets.only(left: LunaUI.DEFAULT_MARGIN_SIZE),
//       color: Theme.of(context).canvasColor,
//       height: LunaTextInputBar.defaultHeight,
//       width: LunaTextInputBar.defaultHeight,
//     );
//   }
// }
