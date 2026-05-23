
import 'package:flutter/material.dart';

enum BlockedList { white, black }

class ToggleWhitelistBlacklist extends StatefulWidget{
  const ToggleWhitelistBlacklist({super.key});

  @override
  State<ToggleWhitelistBlacklist> createState() => _ToggleWhitelistBlacklistState();
}

class _ToggleWhitelistBlacklistState extends State<ToggleWhitelistBlacklist>{
  BlockedList blockedListView = BlockedList.white;

  @override
  Widget build(BuildContext context){
    return SegmentedButton<BlockedList>(
      segments: const <ButtonSegment<BlockedList>>[
        ButtonSegment<BlockedList>(
          value: BlockedList.white,
          label: Text("Whitelist"),
          icon: Icon(
            Icons.assignment_outlined
          )
        ),
        ButtonSegment<BlockedList>(
          value: BlockedList.black,
          label: Text("Blacklist"),
          icon: Icon(
            Icons.assignment_rounded
          )
        )
      ],
      selected: <BlockedList>{blockedListView},
      onSelectionChanged: (Set<BlockedList> newSelection){
        setState(() {
          blockedListView = newSelection.first;
        });
      },
    );
  }
}