import 'dart:async';

import 'package:comet_news/core/constants/palette.dart';
import 'package:comet_news/features/view_news/presenter/pages/home_page.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('assets/splash_screen_image.png')),
      ),
    );
  }
}
