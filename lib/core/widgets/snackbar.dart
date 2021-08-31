import 'package:comet_news/core/constants/palette.dart';
import 'package:flutter/material.dart';

class Snackbar extends SnackBar {
  final String message;
  Snackbar({required this.message})
      : super(
          backgroundColor: Colors.white,
          content: Text(
            message,
            style: TextStyle(color: Palette.deepBlue),
          ),
        );
}
