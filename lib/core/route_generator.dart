import 'package:comet_news/features/view_news/domain/entities/news_info.dart';
import 'package:comet_news/features/view_news/presenter/pages/home_page.dart';
import 'package:comet_news/features/view_news/presenter/pages/news_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class RouteGenerator {
  static Widget _errorPage() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 32, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text('Error Page'),
          ],
        ),
      ),
    );
  }

  static List<Route<dynamic>> generateInitialRoutes(String name) {
    return [MaterialPageRoute(builder: (_) => Wrapper())];
  }

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case NewsPage.routeName:
        if (settings.arguments is NewsInfo)
          return MaterialPageRoute(
              builder: (_) =>
                  NewsPage(newsInfo: settings.arguments as NewsInfo));
        return MaterialPageRoute(builder: (_) => _errorPage());
      default:
        return MaterialPageRoute(builder: (_) => _errorPage());
    }
  }
}
