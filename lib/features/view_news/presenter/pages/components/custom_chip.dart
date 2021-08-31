import 'package:comet_news/core/constants/palette.dart';
import 'package:comet_news/features/view_news/presenter/pages/home_page.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final ChipInfo info;
  final bool isSelected;
  const CustomChip({Key? key, required this.info, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Palette.deepBlue : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(
            color: isSelected ? Palette.deepBlue : Palette.lightGrey,
            width: 1,
          ),
        ),
        child: Text(
          info.text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Palette.background : Palette.deepBlue,
          ),
        ),
      ),
    );
  }
}