import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/modules/transmission.dart';
import 'package:lunasea/modules/transmission/core/types.dart';

class TransmissionTorrentSearchBarSortButton extends StatefulWidget {
  final ScrollController controller;

  const TransmissionTorrentSearchBarSortButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TransmissionTorrentSearchBarSortButton> createState() => _State();
}

class _State extends State<TransmissionTorrentSearchBarSortButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<TransmissionState>(
          builder: (context, state, _) => LunaPopupMenuButton<TransmissionTorrentSorting>(
            tooltip: 'transmission.SortTorrents'.tr(),
            icon: Icons.sort_rounded,
            onSelected: (result) {
              if (state.torrentSortType == result) {
                state.torrentsSortAscending = !state.torrentsSortAscending;
              } else {
                state.torrentsSortAscending = true;
                state.torrentSortType = result;
              }
              widget.controller.animateToStart();
            },
            itemBuilder: (context) => List<PopupMenuEntry<TransmissionTorrentSorting>>.generate(
              TransmissionTorrentSorting.values.length,
              (index) => PopupMenuItem<TransmissionTorrentSorting>(
                value: TransmissionTorrentSorting.values[index],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TransmissionTorrentSorting.values[index].readable,
                      style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_H3,
                        color: state.torrentSortType == TransmissionTorrentSorting.values[index] ? LunaColours.accent : Colors.white,
                      ),
                    ),
                    if (state.torrentSortType == TransmissionTorrentSorting.values[index])
                      Icon(
                        state.torrentsSortAscending ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        size: LunaUI.FONT_SIZE_H2,
                        color: LunaColours.accent,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        height: LunaTextInputBar.defaultHeight,
        width: LunaTextInputBar.defaultHeight,
        margin: const EdgeInsets.only(left: LunaUI.DEFAULT_MARGIN_SIZE),
        color: Theme.of(context).canvasColor,
      );
}
