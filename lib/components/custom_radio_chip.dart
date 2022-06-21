import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:utility_custom_radio_chip/constants/colors.dart';

enum ChipType { text, check }

class CustomChips extends StatefulWidget {
  final ChipType chipType;
  final List<dynamic> chipItems;
  final Function(int index) selectedChip;

  const CustomChips(
      {Key? key,
      required this.chipType,
      required this.chipItems,
      required this.selectedChip})
      : super(key: key);

  @override
  CustomChipsState createState() => CustomChipsState();
}

class CustomChipsState extends State<CustomChips> {
  late List<bool> chipClicked;

  @override
  void initState() {
    super.initState();
    chipClicked = List<bool>.filled(widget.chipItems.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.chipItems
            .asMap()
            .entries
            .map((element) => InkWell(
                  onTap: () {
                    setState(() {
                      chipClicked.fillRange(0, widget.chipItems.length, false);
                      chipClicked[element.key] = true;
                      widget.selectedChip(element.key);
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: chipClicked[element.key]
                            ? Border.all(width: 5, color: WHITE)
                            : null,
                        borderRadius: BorderRadius.circular(25.0),
                        color: widget.chipType == ChipType.check
                            ? element.value
                            : Theme.of(context).colorScheme.secondaryContainer,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(
                                      chipClicked[element.key] ? 0.2 : 0.4),
                              offset: const Offset(0, 2),
                              blurRadius: chipClicked[element.key] ? 2.0 : 0.75,
                              spreadRadius:
                                  chipClicked[element.key] ? 2.0 : 0.75)
                        ]),
                    child: widget.chipType == ChipType.check
                        ? (chipClicked[element.key]
                            ? const Icon(Icons.done)
                            : const SizedBox.shrink())
                        : widget.chipType == ChipType.text
                            ? Center(
                                child: Text(
                                  element.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox.shrink(),
                  ),
                ))
            .toList());
  }
}
