import 'package:comet_news/core/constants/nums.dart';
import 'package:comet_news/core/constants/palette.dart';
import 'package:comet_news/features/view_news/presenter/notifiers/view_news_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  const SearchBar({Key? key, required this.controller}) : super(key: key);

  static const String _hintText = 'Search news';

  OutlineInputBorder _border({bool isFocused = false}) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      borderSide: isFocused
          ? const BorderSide(color: Palette.navyBlue, width: 2)
          : const BorderSide(color: Palette.lightGrey, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (text) {
        if (text.isNotEmpty)
          context.read<ViewNewsNotifier>().getSearchedNews(context, text);
      },
      style: const TextStyle(
        color: Palette.deepBlue,
        fontSize: Nums.mediumFontSize,
        // fontFamily: Strings.poppintsRegularFont,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: _hintText,
        hintStyle: const TextStyle(
          color: Palette.lightGrey,
          fontWeight: FontWeight.bold,
          fontSize: Nums.mediumFontSize,
          // fontFamily: Strings.poppintsRegularFont,
        ),
        prefixIcon:
            const Icon(Icons.search, color: Palette.grey, size: Nums.largeIconSize),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(isFocused: true),
      ),
    );
  }
}
